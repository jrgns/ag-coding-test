class FileList
  include Enumerable

  attr_reader :store

  def initialize(file)
    file = File.new(file) if file.is_a?(String)
    file.each_line do |line|
      parse(line)
    end
  end

  def each
    store.each { |elm| yield elm }
  end

  def each_pair
    store.each_pair do |k,v|
      yield k, v
    end
  end
end
