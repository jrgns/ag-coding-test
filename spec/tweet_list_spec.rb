require 'spec_helper'
require 'tweet_list'

describe TweetList do
  subject { TweetList.new(StringIO.new(tweet_lines)) }

  it 'has an Array store' do
    expect(subject.store).to be_an(Array)
  end

  context '#parse' do
    it 'only adds correctly formed lines to the store in the correct order' do
      expect(subject.store.count).to eq(3)
      expect(subject.store[0]).to eq({user: 'Alan', tweet: 'If you have a procedure with 10 parameters, you probably missed some.'})
      expect(subject.store[1]).to eq({user: 'Ward', tweet: 'There are only two hard things in Computer Science: cache invalidation, naming things and off-by-1 errors.'})
      expect(subject.store[2]).to eq({user: 'Alan', tweet: 'Random numbers should not be generated with a method chosen at random.'})
    end

    it 'allows for spaces in usernames' do
      list = TweetList.new(StringIO.new('Spaces are Cool> I like spaces     '))
      expect(list.store[0]). to eq({user: 'Spaces are Cool', tweet: 'I like spaces     '})
    end

    it 'restricts tweets to 140 characters' do
      tweet = Array.new(4, 'This line is longer than 140 characters.').join(' ')
      line = 'Mr Verbose> ' + tweet
      list = TweetList.new(StringIO.new(line))
      expect(list.store[0][:tweet].length).to be(140)
    end
  end
end

