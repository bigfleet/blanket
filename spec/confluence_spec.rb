require File.dirname(__FILE__) + "/spec_helper.rb"

describe "The Confluence source" do
  
  before(:each) do
    @file = File.dirname(__FILE__) + "/fixtures/confluence.yml"
    @reader = Blanket::Reader.new(@file)
    @instance = Confluence.new(@reader)
    @date_string = Date.today.strftime("%Y_%m_%d")
  end
  
  it "should give back an accurate set of default attributes" do
    atts = Confluence.default_attributes
    atts["host"].should == "yourhost.com"
  end
  
  it "should delegate methods to its configuration" do
    @instance.source_type.should == "Confluence"
    @instance.remote_directory.should == "/path/to/remote/confluence/backups"
  end
  
  it "should assemble the remote backup path properly" do
    @instance.remote_backup_path.should == "/path/to/remote/confluence/backups/daily-backup-#{@date_string}.zip"
  end
  
  it "should assemble the local backup path properly" do
    @instance.local_backup_path.should == "/path/to/local/confluence/backups/daily-backup-#{@date_string}.zip"
  end
  
end