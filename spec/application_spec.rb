require 'spec_helper'
require 'application'

describe Application do
  it 'takes an interface as an initializaton argument' do
    expect{ Application.new(STDOUT) }.to raise_error 'Interface needs to implement `out`'
  end

  it 'defaults to CLIInterface if none is given' do
    expect(subject.interface).to be_a(CLIInterface)
  end

  it 'produces the correct output' do
    users  = StringIO.new(user_lines)
    tweets = StringIO.new(tweet_lines)

    expect{ subject.execute(users, tweets) }.to output(File.read('output.txt')).to_stdout
  end
end
