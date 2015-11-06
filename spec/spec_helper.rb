libdir = File.expand_path(File.dirname(__FILE__) + '/../lib')
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'rspec'

RSpec.configure do |config|
  config.alias_example_to :fit, focus: true
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end

require 'file_list'
class TestArray < FileList
  def initialize(file)
    @store = []
    super file
  end

  def parse(line)
    line = line.strip
    store << line
  end
end

class TestHash < FileList
  def initialize(file)
    @store = {}
    super file
  end

  def parse(line)
    line = line.strip
    store[line] = line
  end
end

def user_lines
  File.read('user.txt')
end

def tweet_lines
  File.read('tweet.txt')
end
