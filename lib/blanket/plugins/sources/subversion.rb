class Subversion < Source
  
  def initialize(reader)
    @reader = reader
  end
  
  def self.attribute_symbols
    [:source_type, :host, :user, :password, :repository, :remote_path, :local_path ]
  end
  
  def self.default_source_type
    "Subversion"
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
  
  def self.default_repository
    "/path/to/repo"
  end
  
  def self.default_remote_path
    "/path/to/remote/backup-file"
  end
  
  def self.default_local_path
    "/path/to/local/backup-file"
  end
    
  def remote_backup_path
    remote_path
  end
  
  def local_backup_path
    local_path
  end
  
  def prep_command
    "svnadmin dump #{repository} > #{remote_backup_path}"
  end
  
  def cleanup_command
    noop
  end
  
end