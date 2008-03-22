require 'date'

# Source for backing up MySQL databases.  Uses the mysqldump command on the
# remote system.
class Mysql < Source
  
  def initialize(reader) #:nodoc:
    @reader = reader
  end
  
  def self.attribute_symbols #:nodoc:
    [:source_type, :host, :user, :db_user, :password, 
      :db_password, :database, :dump_options, :remote_path, :local_path ]
  end
  
  def self.default_source_type #:nodoc:
    "Mysql"
  end
  
  def self.default_host
    "yourhost.com"
  end
  
  # Your username on the remote system.
  def self.default_user
    "username"
  end
  
  # The username you use for MySQL access.
  def self.default_db_user
    "username"
  end

  # Your password for the remote system.  May not be needed if you have
  # set up SSH keys.  
  def self.default_password
    "password"
  end
  
  # The password that you use for MySQL access.
  def self.default_db_password
    "password"
  end
  
  # The password that you use for MySQL access.  
  def self.default_database
    "test"
  end
  
  # The full remote path where you would like the MySQL file dumped.
  def self.default_remote_path
    "/path/to/remote/sql-file"
  end
  
  # The path on the client filesystem where the SQL file resides after
  # downloading from the source.  Right now, there is only good support
  # for having this path within your blanket task directory itself.
  # See http://bigfleet.lighthouseapp.com/projects/8764/tickets/4-remove-task-directory-dependence-for-storing-backup-file-on-client  
  def self.default_local_path
    "/path/to/local/sql-file"
  end
  
  # Any options that you'd like to pass to the mysqldump command
  # (other than those required elsewhere) should be here.
  def self.default_dump_options
    ""
  end
  
  def remote_backup_path
    remote_path
  end
  
  def local_backup_path
    local_path
  end
  
  # Command to prepare MySQL download
  def prep_command
    "mysqldump #{dump_options} -u #{db_user} --password=#{db_password} #{database} > #{remote_backup_path}"
  end
  
  # Not implemented yet.
  def cleanup_command
    noop
  end
  
end