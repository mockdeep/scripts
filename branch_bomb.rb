#!/usr/bin/env ruby
# use with care
branch = ARGV[0]
puts branch

puts `git checkout #{branch}`
puts `git merge master`
diff = `git diff master`
if diff == ''
  puts "*" * 80
  puts "Branch #{branch} matches master, sending it to oblivion"
  puts "*" * 80
  `git co master`
  `git branch -d #{branch}`
  puts "...local branch deleted"
  `git push origin :#{branch}`
  puts "...remote branch deleted"
else
  puts "*" * 80
  puts "branches don't match, you're going to have to handle this one yourself"
  puts "*" * 80
end
