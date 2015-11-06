require 'file_list'

class TweetList < FileList
  def initialize(file)
    @store ||= []
    super file
  end

  def parse(line)
    matches = line.chomp.match(/^([^>]+)> ?(.*)/)
    return if matches.nil?
    store << { user: matches[1], tweet: matches[2][0..140] }
  end
end
