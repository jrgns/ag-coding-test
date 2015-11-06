require 'user_list'
require 'tweet_list'
require 'cli_interface'
class Application
  attr_reader :interface

  def initialize(iface = nil)
    # This can be replaced with any other class that provides an out method to produce output
    @interface = iface.nil? ? CLIInterface.new : iface
    raise 'Interface needs to implement `out`' unless interface.respond_to?(:out)
  end

  def execute(user_file, tweet_file)
    users  = UserList.new(user_file)
    tweets = TweetList.new(tweet_file)

    users.each_pair do |leader, followers|
      interface.out leader
      tweets.select{ |elm| followers.include?(elm[:user]) || leader == elm[:user]}.each do |tweet|
        interface.out "@#{tweet[:user]}: #{tweet[:tweet]}"
      end
    end
  end
end
