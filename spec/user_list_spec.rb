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

    it 'handles spaces in usernames' do
      list = UserList.new(StringIO.new('I like spaces follows Alan'))
      expect(list.store.count).to eq(2)
      expect(list.store).to have_key('I like spaces')
      expect(list.store).to have_key('Alan')
    end

    it 'doesn\'t allow greater than signs (>) in username' do
      list = UserList.new(StringIO.new("Some>name follows You\nYou follows Some>name"))
      expect(list.store.count).to eq(0)
    end

    it 'doesn\'t allow commas (,) in username' do
      list = UserList.new(StringIO.new("Some,name follows You\nYou follows Some,name"))
      expect(list.store.count).to eq(3)
      expect(list.store).to have_key('Some')
      expect(list.store).to have_key('name')
      expect(list.store).to have_key('You')
    end
  end
end
