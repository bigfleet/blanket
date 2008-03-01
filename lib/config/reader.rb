class Reader
  
  def initialize(path)
    @path = path
    @attributes = YAML.load_file(@path)
  end
  
  def method_missing(symbol)
    @attributes[symbol.to_s]
   rescue
     nil
  end
  
  def keys
    blanket_type.attribute_symbols
  end
  
  def self.blanketize(path)
    reader = Reader.new(path)
    blanket_type.new(@attributes)
  end
  
  private
  
  def blanket_type
    btype = @attributes["source_type"] || @attributes["sink_type"]
    Object.const_get(btype)
  end
  
end