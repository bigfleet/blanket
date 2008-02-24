class Confluence
  
  def self.default_attributes
    atts = {}
    attribute_symbols.each do |sym|
      sym_string = "default_"+sym.to_s
      default_sym = sym_string.to_sym
      val = self.send(default_sym)
      atts[sym.to_s] = val
    end
    atts
  end
  
  def self.attribute_symbols
    [:blanket_type, :host, :user, :password, :directory, :bucket]
  end
  
  def self.default_blanket_type
    "Confluence"
  end
  
  def self.default_host
    "yourhost.com"
  end
  
  def self.default_user
    "username"
  end
  
  def self.default_password
    "password"
  end
  
  def self.default_directory
    "/path/to/confluence/backups"
  end
  
  def self.default_bucket
    "s3-bucket"
  end
  
end