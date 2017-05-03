#!/usr/bin/env ruby
require 'mechanize'
# require 'pry'

class PodScraper
  attr_accessor :mech

  OUTPUT_FOLDER = File.expand_path('~/Dropbox/podcasts/taking_control/')
  SOURCE_LINK = 'https://takecontroladhd.com/taking-control-the-podcast-index'
  ARTICLE_LINK_SELECTOR = '.archive-item-link' # 'h2.title > a'
  NEXT_LINK_SELECTOR = 'div.next > a'
  FILE_LINK_MATCHERS = [
    { selector: 'audio > source', attribute: 'src' },
    { selector: '.sqs-audio-embed', attribute: 'data-url' },
  ]
  THROTTLE_TIME = 1
  # FILE_LINK_SELECTOR = 'audio > source' # 'a[title="Download"]'
  # FILE_LINK_ATTRIBUTE = 'src' # 'href'

  def initialize
    self.mech = Mechanize.new
    mech.pluggable_parser['mp3'] = Mechanize::Download
  end

  def call
    page = mech.get(SOURCE_LINK)

    # file_links = aggregate_file_links

    # file_links.each_with_index do |file_link, index|
    #   download_link(file_link, index)
    # end

    sleep(THROTTLE_TIME)
    download_links(page)

    sleep(THROTTLE_TIME)
    while link = next_link(page)
      puts "link: #{link}"
      page = mech.get(link)
      download_links(page)
    end
  end

private

  def download_from_page(page)
    mp3_link = locate_mp3(page)
    puts "downloading: #{mp3_link}"
    mech.get(mp3_link).save(File.join(OUTPUT_FOLDER, File.basename(mp3_link)))
    # raise "all downloaded!"
    # get mp3 link
    # download mp3 link
  end

  def locate_mp3(page)
    FILE_LINK_MATCHERS.each do |matcher|
      element = page.search(matcher[:selector]).first
      break element[matcher[:attribute]] if element
    end
  end

  def download_links(page)
    page.search(ARTICLE_LINK_SELECTOR).each do |link|
      sleep(THROTTLE_TIME)
      download_from_page(mech.get(page.uri.merge(link['href'])))
    end
  end

  def next_link(page)
    link = page.search(NEXT_LINK_SELECTOR).first
    link['href'] if link
  end
end

PodScraper.new.()
