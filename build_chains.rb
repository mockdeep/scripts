#!/usr/bin/env ruby

require 'open3'
require 'cgi'
require_relative './measure_chains'

def chain_tips(git_directory: '.')
  chain_branches(git_directory: git_directory)
    .group_by { |b| b.gsub(CHAIN_SUFFIX, '') }
    .transform_values { |members| members.max_by { |b| b[CHAIN_SUFFIX, 1].to_i } }
end

def reponame(git_directory: '.')
  out, = Open3.capture2("git", "-C", git_directory, "remote", "get-url", "origin")
  out.strip.match(%r{github\.com[:/](.+?)(?:\.git)?$})&.[](1)
end

git_dir = ARGV[0] || '.'

tips = chain_tips(git_directory: git_dir)
if tips.empty?
  puts "No chains found."
  exit 1
end

repo = reponame(git_directory: git_dir)
if repo.nil?
  warn "Could not determine GitHub repo name from remotes."
  exit 1
end

tips.each do |chain, branch|
  puts "Chain: #{chain} → #{branch}"
  if system("git", "-C", git_dir, "push", "--force-with-lease", "origin", branch)
    url = "https://app.circleci.com/pipelines/github/#{repo}?branch=#{CGI.escape(branch)}"
    puts "  Opening: #{url}"
    system("xdg-open", url)
  else
    warn "  Push failed for #{branch}, skipping CircleCI open."
  end
end
