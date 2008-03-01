require 'date'
class Mysql < Source
  
  def self.attribute_symbols
    [:source_type, :host, :username, :db_user, :password, :filename, :database, :dump_options, :backup_file ]
  end
  
  def self.default_source_type
    "Mysql"
  end
  
  def self.default_host
    "yourhost.com"
  end
  
  def self.default_username
    "username"
  end
  
  def self.default_db_user
    "username"
  end
  
  def self.default_password
    "password"
  end
  
  def self.default_database
    "test"
  end
  
  def self.default_backup_file
    "~/test.sql"
  end
  
  def self.default_filename
    "test.sql"
  end
  
  def self.default_dump_options
    ""
  end
  
end