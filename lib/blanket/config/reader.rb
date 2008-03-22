module Blanket
  # The Reader class is in charge of reading the YAML file written by
  # blanket-cfg commands.  
  class Reader
      # initialize the Reader with a path to a file to read
    def initialize(path)
      @path = path
      @attributes = YAML.load_file(@path)
    end
  
    def method_missing(symbol) #:nodoc:
      @attributes[symbol.to_s]
     rescue
       nil
    end
    
    # retrieve a list of keys present in this configuration file
    def keys
      blanket_type.attribute_symbols
    end
    # Given a path, initialize a new reader, using the details therein
    # to instantiate the particular type of source or sink that was
    # read in from disk.
    def self.blanketize(path)
      reader = Reader.new(path)
      blanket_type.new(@attributes)
    end
  
    private
    
    # turn the type determination into Class objects
    def blanket_type
      btype = @attributes["source_type"] || @attributes["sink_type"]
      Object.const_get(btype)
    end
  end
end