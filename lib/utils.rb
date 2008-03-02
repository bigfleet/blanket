module Utils
  
  def method_missing(symbol)
    @reader.send(symbol)
   rescue
     nil
  end
  
  # remote noop command
  def noop
    "echo"
  end
  
  module ClassMethods; end
  def self.included(klass)
    klass.extend(ClassMethods)
  end

  module ClassMethods
    def default_attributes
      atts = {}
      attribute_symbols.each do |sym|
        sym_string = "default_"+sym.to_s
        default_sym = sym_string.to_sym
        val = self.send(default_sym)
        atts[sym.to_s] = val
      end
      atts
    end
  end
end
