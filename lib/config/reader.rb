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
  
  
end