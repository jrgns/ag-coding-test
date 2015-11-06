#!/usr/bin/env ruby
libdir = File.expand_path(File.dirname(__FILE__) + '/lib')
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

if ARGV[0].nil? || ARGV[1].nil?
  puts 'Usage: feed.rb user_file twitter_file'
  exit 1
end

if __FILE__ == $0
  require 'application'
  Application.new.execute(ARGV[0], ARGV[1])
end
