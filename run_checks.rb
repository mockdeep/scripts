#!/usr/bin/env ruby

require "pry"
require "httparty"
require "active_support/all"

NOTICE_USER_ID = ENV.fetch("NOTICE_USER_ID")
NOTICE_API_KEY = ENV.fetch("NOTICE_API_KEY")
HOME_DIR = Pathname.new(File.expand_path("~"))

def check_counts_url(check_id)
  "https://notice.zone/checks/#{check_id}/counts"
end

def post_count(check_id:, count:)
  headers = { "x-api-key": NOTICE_API_KEY, "x-user-id": NOTICE_USER_ID }
  body = { "count[value]": count }

  HTTParty.post(check_counts_url(check_id), headers: headers, body: body)
end

def check_downloads
  puts "checking downloads"
  count = Dir[HOME_DIR.join("Downloads/*")].length

  post_count(check_id: 15, count: count)
  puts "reported #{count} downloads"
end

def check_todo_list
  puts "checking list.txt items"
  count = File.read(HOME_DIR.join("list.txt")).lines.count(&:present?)

  post_count(check_id: 31, count: count)
  puts "reported #{count} list.txt items"
end

def check_pixel_photos
  puts "checking pixel photos"
  count = Dir[HOME_DIR.join("Dropbox/Pixel Camera/*")].length

  post_count(check_id: 32, count: count)
  puts "reported #{count} pixel photos"
end

def check_photos
  puts "checking photos to upload"
  count = Dir[HOME_DIR.join("Dropbox/Photos/**/*")].length

  post_count(check_id: 33, count: count)
  puts "reported #{count} photos to upload"
end

check_downloads
check_todo_list
check_pixel_photos
check_photos
