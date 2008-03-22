require 'date'

# Source for backing up a PostgreSQL database.
#
# Create a PostgreSQL source by running <code>blanket-cfg</code> with the
# <code>-o Postgresql</code> option. Databases are backed up using 
# <code>pg_dump</code> In the source.yml file, set the following options:
#
# [user] Username on the remote system.
# [password] Password on the remote system.
# [host] Domain name of the remote system.
# [db_user] Database username
# [db_password] Database password
# [db_host] Host name on the remote system that <code>pg_dump</code> should connect to. Usually <code>localhost</code> or <code>127.0.0.1</code>.
# [database] Name of the database to backup.
# [dump_options] Optional arguments to <code>pg_dump</code>. The default is <code>--format=custom</code> which outputs the flexible custom archive. See the manual entry on pg_dump[http://www.postgresql.org/docs/8.3/interactive/app-pgdump.html] for more options.
# [remote_path] The location on the remote server where the database backup file is stored temporarily. 
# [local_path] The location on client running the blanket where the database backup is stored before being sent to a sink.
#
# Because <code>pg_dump</code> does not accept a password, you need to put
# your database password into a .pgpass file in your home directory on the 
# server. See the PostgreSQL manual for more information on the 
# password[http://www.postgresql.org/docs/8.3/interactive/libpq-pgpass.html]
# file.
class Postgresql < Source
  
  def initialize(reader) #:nodoc:
    @reader = reader
  end
  
  def self.attribute_symbols #:nodoc:
    [:source_type, :host, :user, :password, :db_user, :db_host,
     :database, :dump_options, :remote_path, :local_path]
  end
  
  def self.default_source_type #:nodoc:
    "Postgresql"
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
  
  def self.default_db_host #:nodoc:
    "127.0.0.1"
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
    "--format=custom"
  end
  
  def remote_backup_path #:nodoc:
    remote_path
  end
  
  def local_backup_path #:nodoc:
    local_path
  end
  
  # Command to prepare the Postgresql backup file. Runs <code>pg_dump</code>.
  def prep_command #:nodoc:
    "pg_dump #{dump_options} -U #{db_user} -h #{db_host} #{database} > #{remote_backup_path}"
  end
  
  def cleanup_command #:nodoc:
    noop
  end
  
end