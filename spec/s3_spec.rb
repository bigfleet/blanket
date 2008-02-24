require File.dirname(__FILE__) + "/spec_helper.rb"

describe "The S3 sink" do
  
  it "should give back an accurate set of default attributes" do
    atts = S3.default_attributes
    atts["access_key_id"].should == "your-id"
  end
  
end