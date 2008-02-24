load File.dirname(__FILE__) + "/spec_helper.rb"

describe "The Confluence source" do
  
  it "should give back an accurate set of default attributes" do
    atts = Confluence.default_attributes
    atts["host"].should == "yourhost.com"
  end
  
end