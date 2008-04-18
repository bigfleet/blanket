require 'date'

# Source for backing up a MySQL database.
#
# Create a MySQL source by running <code>blanket-cfg</code> with the
# <code>-o Mysql</code> option. Databases are backed up using 
# <code>mysqldump</code> In the source.yml file, set the following options:
#
# [user] Username on the remote system.
# [password] Password on the remote system.
# [host] Domain name of the remote system.
# [db_user] Database username
# [db_password] Database password
# [db_host] Host name on the remote system that <code>mysqldump</code> should connect to. Usually <code>localhost</code> or <code>127.0.0.1</code>.
# [database] Name of the database to backup.
# [dump_options] Optional arguments to <code>mysqldump</code>. See the manual entry on mysqldump[http://dev.mysql.com/doc/refman/5.0/en/mysqldump.html] for more options.
# [remote_path] The location on the remote server where the database backup file is stored temporarily. 
# [local_path] The location on client running the blanket where the database backup is stored before being sent to a sink.

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
  
  def self.default_host #:nodoc:
    "yourhost.com"
  end
  
  def self.default_user #:nodoc:
    "username"
  end
  
  def self.default_db_user #:nodoc:
    "username"
  end

  def self.default_password #:nodoc:
    "password"
  end
  
  def self.default_db_password #:nodoc:
    "password"
  end
  
  def self.default_database #:nodoc:
    "test"
  end
  
  def self.default_remote_path #:nodoc:
    "/path/to/remote/sql-file"
  end
  
  def self.default_local_path #:nodoc:
    "/path/to/local/sql-file"
  end
  
  def self.default_dump_options #:nodoc:
    ""
  end
  
  # the path to be fetched by the blanket client.  Delegates to the configuration by default.
  def remote_backup_path
    remote_path
  end

  # the path to be copied from to complete the blanket backup.  Delegates to the configuration by default.  
  def local_backup_path
    local_path
  end
  
  # Command to prepare MySQL download on the remote system.
  def prep_command
    "mysqldump #{dump_options} -u #{db_user} --password=#{db_password} #{database} > #{remote_backup_path}"
  end
  
  # Not implemented yet.[http://bigfleet.lighthouseapp.com/projects/8764-blanket/tickets/9-mysql-cleanup-command]
  def cleanup_command
    noop
  end
  
end