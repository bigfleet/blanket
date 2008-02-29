require 'date'
class Confluence < Source
  
  def self.attribute_symbols
    [:source_type, :host, :user, :password, :directory ]
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
  
  def self.default_directory
    "/path/to/confluence/backups"
  end
  
  def self.backup_file
    #On my system, they're named daily-backup-2008_02_24.zip
    today = Date.today
    "daily-backup-#{today.strftime("%Y_%m_%d")}.zip"
  end
  
end