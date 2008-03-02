module Blanket
  class Writer
    def initialize(attributes)
      @attributes = attributes
    end
  
    def write(path)
      File.delete(path) if File.exist?(path)
      write_to = File.new(path, File::CREAT, 0644)
      File.open(path, "w") do |out|
        YAML.dump(@attributes, out)
      end
    end
  end
end