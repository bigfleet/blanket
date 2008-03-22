require 'date'

# A Source that's aware of the Confluence wiki's particular strategy towards
# backups.  Confluence makes its own when you ask it to, so this takes care
# of uploading them to an off-site location.
class Confluence < Source
  
  def initialize(reader) #:nodoc:
    @reader = reader
  end
  
  def self.attribute_symbols #:nodoc:
    [:source_type, :host, :user, :password, :remote_directory, :local_directory ]
  end
  
  def self.default_source_type
    "Confluence"
  end
  
  def self.default_host
    "yourhost.com"
  end
  
  # Your username on the remote system.
  def self.default_user
    "username"
  end
  
  # Your password for the remote system.  May not be needed if you have
  # set up SSH keys.
  def self.default_password
    "password"
  end
  
  # The directory on the remote filesystem that you selected for Confluence
  # to make its backups to.  
  def self.default_remote_directory
    "/path/to/remote/confluence/backups"
  end

  # The directory on the client filesystem where the backup file resides.
  def self.default_local_directory
    "/path/to/local/confluence/backups"
  end
  
  # Determines the filename of the most recent backup made by Confluence.
  def self.filename
    #On my system, they're named daily-backup-2008_02_24.zip
    today = Date.today
    "daily-backup-#{today.strftime("%Y_%m_%d")}.zip"
  end
  
  # The full remote path of the most recent Confluence backup.
  def remote_backup_path
    [remote_directory, Confluence.filename].join('/')
  end
  
  # The full local path of the most recent Confluence backup.
  def local_backup_path
    [local_directory, Confluence.filename].join('/')
  end
  
  def prep_command #:nodoc:
    noop
  end
  
  # Not implemented yet
  def cleanup_command
    noop
  end
  
  
end