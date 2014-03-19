#!/usr/bin/env ruby

# a short script for exporting tasks from Asana

require 'rubygems'
require 'json'
require 'net/https'
API_KEY = <your api key here>

ASANA_URL = 'https://app.asana.com/api/1.0'

class GetRequest

  attr_accessor :uri
  def initialize(url)
    self.uri = URI(url)
  end

  def request
    Net::HTTP::Get.new(uri.path).tap do |request|
      request.basic_auth(API_KEY, '')
    end
  end

  def parsed_response
    JSON.parse(response.body)
  end

  def response
    http.start { |http| http.request(request) }
  end

  def header
    { 'Content-Type' => 'application/json' }
  end

  def http
    @http ||= Net::HTTP.new(uri.host, uri.port).tap do |http|
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    end
  end

end

class Workspace

  WORKSPACE_URL = "#{ASANA_URL}/workspaces"

  attr_accessor :id, :name

  def self.each
    all.each { |workspace| yield(workspace) }
  end

  def self.all
    @all ||= parsed_workspaces
  end

  def self.parsed_workspaces
    request_workspaces.collect { |data| new(data.fetch('id'), data.fetch('name')) }
  end

  def self.request_workspaces
    GetRequest.new(WORKSPACE_URL).parsed_response['data']
  end

  def initialize(id, name)
    self.id = id
    self.name = name
    p "New workspace: #{name}"
  end

  def projects
    request_projects.collect { |data| new_project(data) }
  end

  def request_projects
    GetRequest.new(projects_uri).parsed_response['data']
  end

  def projects_uri
    "#{WORKSPACE_URL}/#{id}/projects"
  end

  def new_project(params)
    Project.new(params.fetch('id'), params.fetch('name'), self)
  end

  def to_s
    "Workspace -> id: #{id}, name: #{name}"
  end

end

class Project

  PROJECT_URL = "#{ASANA_URL}/projects"

  attr_accessor :id, :name, :workspace

  def self.each
    all.each { |project| yield(project) }
  end

  def self.all
    @all ||= Workspace.all.flat_map(&:projects)
  end

  def initialize(id, name, workspace)
    self.id = id
    self.name = name
    self.workspace = workspace
  end

  def tasks
    @tasks ||= collect_tasks
  end

  def collect_tasks
    task_prefix = ''
    tasks = []
    request_tasks.each do |data|
      name = data.fetch('name')
      if name.end_with?(':')
        task_prefix = "#{name} "
      else
        name = "#{task_prefix}#{name}"
        tasks << Task.new(data.fetch('id'), name, self)
      end
    end
    tasks
  end

  def request_tasks
    GetRequest.new(tasks_uri).parsed_response['data']
  end

  def tasks_uri
    "#{PROJECT_URL}/#{id}/tasks?completed_since=now"
  end

  def to_s
    "---- Workspace -> #{workspace.name}, Project -> #{name} ----"
  end

end

class Task

  attr_accessor :id, :name, :project

  def self.all
    @all ||= Project.all.flat_map(&:tasks)
  end

  def initialize(id, name, project)
    self.id = id
    self.name = name
    self.project = project
  end

  def to_s
    name
  end

end

Project.all.each do |project|
  puts project
  puts project.tasks
end
