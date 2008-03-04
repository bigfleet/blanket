class RemoteDirectory < Source
  
  def initialize(reader)
    @reader = reader
  end
  
  def self.attribute_symbols
    [:source_type, :host, :user, :password, :remote_directory, :local_path ]
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
  
  def self.default_remote_directory
    "/path/to/remote/target/directory"
  end
  
  def self.default_local_path
    "/path/to/local/blanket"
  end
    
  def remote_backup_path
    full_tarfile+".gz"
  end
  
  def local_backup_path
    local_path
  end
  
  def tar_directory
    rp = Pathname.new(remote_directory)
    rp.dirname.to_s
  end
  
  def tarfile
    rp = Pathname.new(remote_directory)    
    rp.basename.to_s+".tar"
  end
  
  def full_tarfile
    [tar_directory, tarfile].join("/")
  end
  
  def prep_command
    "tar cvf #{full_tarfile} #{remote_directory}; gzip -f #{full_tarfile}"
  end
  
  def cleanup_command
    noop
  end
  
end