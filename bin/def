#!/usr/bin/env ruby
# coding: utf-8

require "rubygems"
require "nokogiri"
require 'open-uri'

if ARGV.count != 1
  $stderr.puts "Usage: #{$0} (word)"
  exit 1
end

begin
  word = ARGV.first
  url = "http://dictionary.reference.com/browse/#{word}"
  page = Nokogiri::HTML(open(url))
  if page.class.to_s != "Nokogiri::HTML::Document"
    $stderr.puts "Error: failed to load web page"
    exit 1
  end
  i = 1
  page.css('div[class=def-content]').each do |d|
    definition = d.text.gsub("\n", "")
    puts "#{i}. #{definition}"
    i += 1
  end
  exit 0
rescue
  $stderr.puts "Error: #{$!}"
  exit 1
end
