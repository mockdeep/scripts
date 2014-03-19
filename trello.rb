#!/usr/bin/env ruby
require 'trello'

Thread.abort_on_exception = true

Trello.configure do |config|
  config.developer_public_key = ENV['TRELLO_DEVELOPER_PUBLIC_KEY']
  config.member_token = ENV['TRELLO_MEMBER_TOKEN']
end

board_id = <board id here>
lists = {}
project_name = nil

File.readlines('./asana.txt').each do |line|
  line = line.chomp
  if line.start_with?('[Project]')
    project_name = line.split[1..-1].join(' ')
    lists[project_name] = []
  else
    raise 'no project name!' unless project_name
    lists[project_name] << line
  end
end

board = Trello::Board.find(board_id)

threads = []

lists.each do |name, tasks|
  list = board.lists.detect { |list| list.name == name }
  list ||= Trello::List.create(name: name, board_id: board.id)
  threads << Thread.new do
    # create all tasks for a list in the same thread to preserve order
    tasks.each do |task|
      Trello::Card.create(name: task, list_id: list.id)
      # rate limiting without some sort of sleep, this seems to work
      sleep(0.1)
    end
  end
end

threads.each(&:join)
