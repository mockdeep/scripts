#!/usr/bin/env ruby
# use with care
class Differ

  attr_accessor :base_branch, :bomb_branch, :git_method

  def initialize(bomb_branch=nil, git_method='merge')
    self.bomb_branch = bomb_branch || current_branch
    raise 'I can\'t let you do that, Bob' if bomb_branch == 'master'

    self.git_method = git_method
  end

  def same?(base_branch)
    raise 'But you have so much left to live for!' if bomb_branch == base_branch

    self.base_branch = base_branch

    puts `git checkout #{bomb_branch}`
    puts `git #{git_method} #{base_branch}`

    if conflict?
      puts '*' * 80
      puts 'Conflict! Abort!'
      puts '*' * 80
      puts `git #{git_method} --abort`
      return false
    end

    `git push origin #{bomb_branch}`
    diff = `git diff #{base_branch}`
    diff == ''
  end

  def current_branch
    `git branch | grep ^\*`.split.last
  end

  def conflict?
    `git status` !~ /nothing to commit/
  end

end

branch = ARGV[0]
puts branch

differ = Differ.new(branch, 'merge')

if differ.same?('master') || differ.same?('staging')
  puts "*" * 80
  puts "Branch #{differ.bomb_branch} matches #{differ.base_branch}, sending it to oblivion"
  puts "*" * 80
  `git co #{differ.base_branch}`
  `git branch -d #{differ.bomb_branch}`
  puts "...local branch deleted"
  `git push origin :#{differ.bomb_branch}`
  puts "...remote branch deleted"
else
  puts "*" * 80
  puts "branches don't match, you're going to have to handle this one yourself"
  puts "*" * 80
end
