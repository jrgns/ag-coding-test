require 'spec_helper'
require 'file_list'

describe FileList do
  subject { FileList.new(StringIO.new) }
  it 'is Enumerable' do
    expect(subject).to be_a_kind_of(Enumerable)
  end

  it 'takes a filename or IO Object as an an initializaton argument' do

  end

  it 'needs an implementation of the parse method' do
    expect{
      FileList.new(StringIO.new('once'))
    }.to raise_error(NoMethodError, /^undefined method `parse' for/)
  end

  it 'can iterate through each element in the store' do
    logger = double()

    expect(logger).to receive(:add).exactly(3).times

    TestArray.new(StringIO.new("once\ntwice\nthrice")).each do |line|
      logger.add line
    end
  end

  it 'can iterate through each pair in the store' do
    logger = double()

    expect(logger).to receive(:add).exactly(3).times

    TestHash.new(StringIO.new("once\ntwice\nthrice")).each_pair do |line|
      logger.add line
    end
  end
end
