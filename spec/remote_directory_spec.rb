require File.dirname(__FILE__) + "/spec_helper.rb"

describe "The remote directory source" do
  
  before(:each) do
    @file = File.dirname(__FILE__) + "/fixtures/remote_directory.yml"
    @reader = Blanket::Reader.new(@file)
    @instance = RemoteDirectory.new(@reader)
  end
  
  it "should decompose a directory into appropriate components" do
    @instance.prep_command.should == 
      "tar cvf /path/to/remote/directory.tar /path/to/remote/directory; gzip -f /path/to/remote/directory.tar"
  end
  
end