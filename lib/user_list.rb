require 'file_list'

class UserList < FileList
  def initialize(file)
    @store ||= Hash.new do |h, k|
      h[k] = []
    end
    super file
    @store = Hash[@store.sort]
  end

  def parse(line)
    _, follower, leaders = line.strip.match(/^(\S+) ?follows ?(.*)$/).to_a
    return if follower.nil? || leaders.nil?
    leaders.split(/, ?/).each do |leader|
      store[follower] << leader unless store[follower].include?(leader)
      store[leader] = [] unless store.has_key?(leader)
    end
  end
end
