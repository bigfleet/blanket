#load File.dirname(__FILE__) + "/spec_helper.rb"
# Don't include the spec helper here to determine 

describe "To run the app" do

  it "you should have the aws-s3 gem installed" do
    lambda{
      require 'rubygems'
      gem 'aws-s3'
    }.should_not raise_error
  end
  
  it "you should have the net-ssh gem installed" do
    lambda{
      require 'rubygems'
      gem 'net-ssh'
    }.should_not raise_error
  end
  
end