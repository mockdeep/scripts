#!/usr/bin/env ruby

require 'open3'

CHAIN_SUFFIX = /_(\d+)$/

def chain_branches(git_directory: '.')
  out, = Open3.capture2("git", "-C", git_directory, "branch")
  out.scan(/^[* ] (.+#{CHAIN_SUFFIX.source})/).map(&:first)
end

def measure_chains(git_directory: '.')
  chain_branches(git_directory: git_directory)
    .map { |branch| branch.gsub(CHAIN_SUFFIX, '') }
    .tally
    .sort_by(&:last)
end

if __FILE__ == $PROGRAM_NAME
  measure_chains.each { |branch, count| puts "#{count.to_s.ljust(4)} #{branch}" }
end
