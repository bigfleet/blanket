require File.dirname(__FILE__) + "/spec_helper.rb"

describe "The YAML config file" do
  
  describe "for S3" do
    before do
      file = File.dirname(__FILE__) + "/fixtures/s3-info.yml"
      @reader = Reader.new(file)
    end
    
    it "should instantiate a reader from a file" do
      @reader.should_not be_nil
    end
    
    it "should define the access key id" do
      @reader.access_key_id.should == "some_key"
    end
    
    it "should define the secret key id" do
      @reader.secret_access_key.should == "some_secret"
    end
    
  end
  
  describe "for Confluence" do
    before do
      file = File.dirname(__FILE__) + "/fixtures/confluence.yml"
      @reader = Reader.new(file)
    end
    
    it "should define the blanket type as Confluence" do
      @reader.blanket_type.should == "Confluence"
    end
    
    it "should define the host" do
      @reader.host.should == "foobar.com"
    end
    
    it "should define the user" do
      @reader.user.should == "foo"
    end
    
    it "should define the password" do
      @reader.password.should == "topsecret"
    end
    
    it "should define the backup directory" do
      @reader.directory.should == "/var/confluence/backups"
    end
    
    it "should define the bucket name" do
      @reader.bucket.should == "com.foobar.confluence"
    end
    
  end
  
end


