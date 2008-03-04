class SingleFile < Source
  
  def initialize(reader)
    @reader = reader
  end
  
  def self.attribute_symbols
    [:source_type, :host, :user, :password, :remote_path, :local_path ]
  end
  
  def self.default_source_type
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
  
  def self.default_remote_path
    "/path/to/remote/target/file"
  end
  
  def self.default_local_path
    "/path/to/local/blanket"
  end
    
  def remote_backup_path
    remote_path
  end
  
  def local_backup_path
    local_path
  end
  
  def prep_command
    noop
  end
  
  def cleanup_command
    noop
  end
  
end