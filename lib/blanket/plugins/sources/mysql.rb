require 'date'
class Mysql < Source
  
  def initialize(reader)
    @reader = reader
  end
  
  def self.attribute_symbols
    [:source_type, :host, :user, :db_user, :password, 
      :db_password, :database, :dump_options, :remote_path, :local_path ]
  end
  
  def self.default_source_type
    "Mysql"
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
  
  def self.default_db_password
    "password"
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
    ""
  end
  
  def remote_backup_path
    remote_path
  end
  
  def local_backup_path
    local_path
  end
  
  def prep_command
    "mysqldump #{dump_options} -u #{db_user} --password=#{db_password} #{database} > #{remote_backup_path}"
  end
  
  def cleanup_command
    noop
  end
  
end