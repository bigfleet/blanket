require File.dirname(__FILE__) + "/spec_helper.rb"

describe "The Blanket config writer" do
  
  before do
    @confluence_file = File.dirname(__FILE__) + "/fixtures/confluence.yml"
    @atts = YAML.load_file(@confluence_file)
    @writer = Blanket::Writer.new(@atts)
    @tempfile = File.dirname(__FILE__)+"/tmp/temp.yml"
  end
  
  it "should write a config file that the reader can read" do
    @writer.write(@tempfile)
    reader = Blanket::Reader.new(@tempfile)
    reader.source_type.should == "Confluence"
  end
  
  it "should write a config file that matches the incoming parameters" do
    @writer.write(@tempfile)
    @reader = Blanket::Reader.new(@confluence_file)
    @write_reader = Blanket::Reader.new(@tempfile)
    [:source_type, :host, :user, :password, :remote_directory, :local_directory].each do |sym|
      @write_reader.send(sym).should == @reader.send(sym)
    end
  end
  
  it "should fail gracefully if it can't write the config file for whatever reason"

end