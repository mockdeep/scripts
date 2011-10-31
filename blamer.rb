require 'set'

def add_hashes(main_hash, hash_to_add)
  hash_to_add.each do |key, value|
    main_hash[key] += value
  end
end

def blame_this(filename)
  blame_output = `git blame #{filename}`
  blame_hash = Hash.new(0)
  blame_output.each do |line|
    name = line.split('(')[1].split.first
    blame_hash[name] += 1
  end
  blame_hash
end

bash_commands = [
  # get a list of everything in the current git tree:
  "git ls-tree -r HEAD",
  # trim to just the file path (by removing the first 53 characters):
  "sed -re 's/^.{53}//'",
  # use `file` to get a file description for each of the files:
  "while read filename; do file \"$filename\"; done",
  # find all of the files that are text:
  "grep -E ': .*text'",
  # and trim off the description, so now we've just got the file paths:
  "sed -r -e 's/: .*//'",
]
puts "Getting list of files...this could take a while."
filenames = `#{bash_commands.join(' | ')}`
puts "Done...now analyzing directories"

# features to add:
skip_directories = ['vendor']
ignore_spaces = true

depth = 2
directories = Set.new
blame_hash = {}
filenames.sort.each do |filename|
  split = filename.split('/')
  depth.times do |i|
    if split.size > depth+1
      key = split[0,i+1].join('/')
    else
      key = split[0..-2].join('/')
    end
    if !directories.member?(key)
      directories << key
      puts "analyzing directory: #{key}"
    end
    blame_this(filename)
    blame_hash[key] ||= Hash.new(0)
    add_hashes(blame_hash[key], blame_this(filename))
  end
end
keys = blame_hash.keys.sort
keys.each do |key|
  counts = ""
  index = 0
  blame_hash[key].invert.sort.reverse.each do |number, name|
    index += 1
    counts << "#{index.to_s.rjust(2)}. #{name.rjust(8)} -> #{number.to_s.rjust(6)} | "
    break if index > 6
  end
  puts "#{key.ljust(23)}: #{counts}"
end
