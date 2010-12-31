File.open('/home/explorer/Desktop/french').each do |line|
  puts line.split("\t").join(':')
end
