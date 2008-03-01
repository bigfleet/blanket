class Subversion < Source
  
  def self.attribute_symbols
    [:source_type, :host, :user, :password, :repository, :backup_file, :filename ]
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
  
  def self.default_backup_file
    "~/repo.svn.dump"
  end
  
  def self.default_filename
    "repo.svn.dump"
  end
  
end