require 'spec_helper'
require 'user_list'

describe UserList do
  subject { UserList.new(StringIO.new(user_lines)) }

  it 'has a Hash store' do
    expect(subject.store).to be_a(Hash)
  end

  it 'has a store sorted by key' do
    hash = TestHash.new(StringIO.new("bac\ncab\nabc"))
    expect(hash.store).to eq({'abc' => 'abc', 'bac' => 'bac', 'cab' => 'cab'})
  end

  context '#parse' do
    it 'adds correctly formed lines to the store' do
      expect(subject.store).to have_key('Alan')
      expect(subject.store['Alan']).to eq(['Martin'])
      expect(subject.store).to have_key('Ward')
      expect(subject.store['Ward']).to eq(['Alan', 'Martin'])
    end

    it 'ensures that all users mentioned in the file are in the store' do
      expect(subject.store.count).to eq(3)
      expect(subject.store).to have_key('Martin')
      expect(subject.store['Martin']).to eq([])
    end

    it 'only adds a leader once' do
      expect(subject.store['Ward']).to eq(['Alan', 'Martin'])
    end

    it 'drops malformed lines' do
      expect(subject.store.count).to eq(3)
      expect(subject.store).to_not have_key('Maas')
    end
  end
end
