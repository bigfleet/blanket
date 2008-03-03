require 'date'
class Confluence < Source
  
  def initialize(reader)
    @reader = reader
  end
  
  def self.attribute_symbols
    [:source_type, :host, :user, :password, :remote_directory, :local_directory ]
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
    "/path/to/remote/confluence/backups"
  end
  
  def self.default_local_directory
    "/path/to/local/confluence/backups"
  end
  
  
  def self.filename
    #On my system, they're named daily-backup-2008_02_24.zip
    today = Date.today
    "daily-backup-#{today.strftime("%Y_%m_%d")}.zip"
  end
  
  def remote_backup_path
    [remote_directory, Confluence.filename].join('/')
  end
  
  def local_backup_path
    [local_directory, Confluence.filename].join('/')
  end
  
  def prep_command
    noop
  end
  
  def cleanup_command
    noop
  end
  
  
end