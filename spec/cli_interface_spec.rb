require 'spec_helper'
require 'cli_interface'

describe CLIInterface do
  it 'sends output to STDOUT' do
    expect{ subject.out('sending to stdout') }.to output("sending to stdout\n").to_stdout
  end
end
