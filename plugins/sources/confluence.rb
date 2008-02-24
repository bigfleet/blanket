class Confluence < Source
  
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