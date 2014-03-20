#!/usr/bin/env ruby
require 'trello'

# a script to expand a Trello list onto its own board

board_id = <target board id here>
source_list_id = <source list id here>


Thread.abort_on_exception = true

Trello.configure do |config|
  config.developer_public_key = ENV['TRELLO_DEVELOPER_PUBLIC_KEY']
  config.member_token = ENV['TRELLO_MEMBER_TOKEN']
end

lists = {}
list_name = nil

source_list = Trello::List.find(source_list_id)

source_list.cards.each do |card|
  name = card.name
  if name.include?(':')
    list_name = name.split(':').first
  else
    list_name = 'General'
  end
  lists[list_name] ||= []
  lists[list_name] << name
end

list_names_to_delete = lists.keys.select { |k| lists[k].length == 1 }
list_names_to_delete.each do |list_name|
  lists['General'] += lists.delete(list_name)
end

lists.each do |name, tasks|
  duplicate_tasks = tasks.select { |task| tasks.count(task) > 1 }
  p duplicate_tasks if duplicate_tasks.any?
end

fail 'wtf!' if lists.any? { |k,v| v.uniq.size != v.size }

board = Trello::Board.find(board_id)

threads = []

board_lists = board.lists

lists.each do |name, tasks|
  list = board_lists.detect { |list| list.name == name }
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
