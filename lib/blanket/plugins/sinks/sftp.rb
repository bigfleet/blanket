class Sftp < Sink
  
  def initialize(reader)
    @reader = reader
  end
  
  def self.additional_requirements
    "'capistrano/recipes/sftp'"
  end
  
  def self.attribute_symbols
    [:sink_type, :host, :user, :password, :remote_path, :local_path ]
  end
  
  def self.default_sink_type
    "Sftp"
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
    "/path/to/remote/backup/directory"
  end
  
  def self.default_local_path
    "/path/to/local/blanket"
  end
  
  def cleanup_command
    noop
  end
  
end