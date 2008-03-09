require 'date'
class Postgresql < Source
  
  def initialize(reader)
    @reader = reader
  end
  
  def self.attribute_symbols
    [:source_type, :host, :user, :password, :db_user, :db_host,
     :database, :dump_options, :remote_path, :local_path]
  end
  
  def self.default_source_type
    "Postgresql"
  end
  
  def self.default_host
    "yourhost.com"
  end
  
  def self.default_user
    "username"
  end
  
  def self.default_db_user
    "username"
  end
  
  def self.default_password
    "password"
  end
  
  def self.default_db_host
    "127.0.0.1"
  end
  
  def self.default_database
    "test"
  end
  
  def self.default_remote_path
    "/path/to/remote/sql-file"
  end
  
  def self.default_local_path
    "/path/to/local/sql-file"
  end
  
  def self.default_dump_options
    "--format=custom"
  end
  
  def remote_backup_path
    remote_path
  end
  
  def local_backup_path
    local_path
  end
  
  def prep_command
    "pg_dump #{dump_options} -U #{db_user} -h #{db_host} #{database} > #{remote_backup_path}"
  end
  
  def cleanup_command
    noop
  end
  
end