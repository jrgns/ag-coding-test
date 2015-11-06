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
    match, follower, leaders = line.strip.match(/^([^>,]+) follows (.*)$/).to_a
    return if match.nil?
    leaders.split(/, ?/).each do |leader|
      next if leader.match(/[>,]/)
      store[leader] = [] unless store.has_key?(leader)
      store[follower] << leader unless store[follower].include?(leader)
    end
  end
end
