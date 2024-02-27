#!/usr/bin/env ruby

def measure_chains(git_directory: '.')
  `git -C #{git_directory} branch`
    .split("\n")
    .select { |branch| branch =~ /\d$/ }
    .map { |branch| branch.gsub(/\*/, '').strip }
    .map { |branch| branch.gsub(/_\d+$/, '') }
    .tally
    .sort_by(&:last)
end

if __FILE__ == $PROGRAM_NAME
  measure_chains.each { |branch, count| puts "#{count.to_s.ljust(4)} #{branch}" }
end
