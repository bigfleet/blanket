load File.dirname(__FILE__) + "/spec_helper.rb"

describe "The YAML config file" do
  
  describe "for S3" do
    before do
      file = File.dirname(__FILE__) + "/fixtures/s3-info.yml"
      @results = YAML.load_file(file)
    end
    
    it "should define the access key id" do
      @results["ACCESS_KEY_ID"].should == "some_key"
    end
    
    it "should define the secret key id" do
      @results["SECRET_ACCESS_KEY"].should == "some_secret"
    end
    
  end
  
  describe "for Confluence" do
    before do
      file = File.dirname(__FILE__) + "/fixtures/confluence.yml"
      @results = YAML.load_file(file)
    end
    
    it "should define the type as Confluence" do
      @results["type"].should == "Confluence"
    end
    
    # type: Confluence
    # host: foobar.com
    # user: foo
    # password: topsecret
    # directory: /usr/local/confluence
    
    it "should define the host" do
      @results["host"].should == "foobar.com"
    end
    
    it "should define the user" do
      @results["user"].should == "foo"
    end
    
    it "should define the password" do
      @results["password"].should == "topsecret"
    end
    
    it "should define the backup directory" do
      @results["directory"].should == "/var/confluence/backups"
    end
    
    it "should define the bucket name" do
      @results["bucket"].should == "com.foobar.confluence"
    end
    
  end
  
end


