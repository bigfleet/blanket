load File.dirname(__FILE__) + "/spec_helper.rb"

describe "The Blanket config writer" do
  
  before do
    @confluence_file = File.dirname(__FILE__) + "/fixtures/confluence.yml"
    @atts = YAML.load_file(@confluence_file)
    @writer = Writer.new(@atts)
    @tempfile = File.dirname(__FILE__)+"/tmp/temp.yml"
  end
  
  it "should write a config file that the reader can read" do
    @writer.write(@tempfile)
    reader = Reader.new(@tempfile)
    Reader.new(@tempfile).blanket_type.should == "Confluence"
  end
  
  it "should write a config file that matches the incoming parameters" do
    @writer.write(@tempfile)
    @reader = Reader.new(@confluence_file)
    @write_reader = Reader.new(@tempfile)
    [:blanket_type, :host, :user, :password, :directory, :bucket].each do |sym|
      @write_reader.send(sym).should == @reader.send(sym)
    end
  end
  
  it "should fail gracefully if it can't write the config file for whatever reason"

end