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
  
  def self.default_source_type #:nodoc:
    "Confluence"
  end
  
  def self.default_host #:nodoc:
    "yourhost.com"
  end
  
  def self.default_user #:nodoc:
    "username"
  end
  
  def self.default_password #:nodoc:
    "password"
  end
  
  def self.default_remote_directory #:nodoc:
    "/path/to/remote/confluence/backups"
  end

  def self.default_local_directory #:nodoc:
    "/path/to/local/confluence/backups"
  end
  
  # Determines the filename of the most recent backup made by Confluence's automated process.
  def self.filename
    #On my system, they're named daily-backup-2008_02_24.zip
    today = Date.today
    "daily-backup-#{today.strftime("%Y_%m_%d")}.zip"
  end
  
  # The full remote path of the most recent Confluence backup, to be
  # downloaded by the blanket client.
  def remote_backup_path
    [remote_directory, Confluence.filename].join('/')
  end
  
  # The full local path of the most recent Confluence backup, to be
  # uploaded by the blanket client
  def local_backup_path
    [local_directory, Confluence.filename].join('/')
  end
  
  
  def prep_command #:nodoc:
    noop
  end
  
  # Not implemented yet.[http://bigfleet.lighthouseapp.com/projects/8764-blanket/tickets/5-confluence-remote-cleanup]
  def cleanup_command
    noop
  end
  
  
end