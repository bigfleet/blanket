module Blanket
  # The Writer class is in charge of writing the YAML file from
  # blanket-cfg commands.
  class Writer
    
    # initialize a write with a hash of attributes to
    # be written to out to disk
    def initialize(attributes)
      @attributes = attributes
    end
    
    # writes the attribute hash to the path provided  
    def write(path)
      File.delete(path) if File.exist?(path)
      write_to = File.new(path, File::CREAT, 0644)
      File.open(path, "w") do |out|
        YAML.dump(@attributes, out)
      end
    end
  end
end