require File.dirname(__FILE__) + "/spec_helper.rb"

describe "The SSH connection" do
  
  before do
    @runner = Runner.new
  end
  
  it "should be able to make a simple connection to a known host and store execution STDOUT" do
    @runner.connect('ls ~', 'jimvanfleet.is-a-geek.com')
    @runner.buffer.should_not be_nil
    @runner.buffer.should_not be_empty
  end
  
end