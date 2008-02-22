require 'yaml'

describe "The YAML config file" do
  
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
      @results["directory"].should == "/usr/local/confluence"
    end
    
  end
  
end


