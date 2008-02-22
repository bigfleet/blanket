describe "To run the app" do

  it "you should have the aws-s3 gem installed" do
    lambda{
      require 'rubygems'
      gem 'aws-s3'
    }.should_not raise_error
  end
  
end