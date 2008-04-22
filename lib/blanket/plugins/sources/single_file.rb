# Source for backing up single file
#
# Create a SingleFile source by running <code>blanket-cfg</code> with the
# <code>-o SingleFile</code> option.
# 
# In the source.yml file, set the following options:
#
# [user] Username on the remote system.
# [password] Password on the remote system.
# [host] Domain name of the remote system.
# [remote_path] The location on the remote server you'd like to blanket.
# [local_path] The location on client running the blanket where the database backup is stored before being sent to a sink.

class SingleFile < Source

  # One additional TODO
  # http://bigfleet.lighthouseapp.com/projects/8764-blanket/tickets/13-document-overwriting-single-file

  
  def initialize(reader) #:nodoc:
    @reader = reader
  end
  
  def self.attribute_symbols #:nodoc:
    [:source_type, :host, :user, :password, :remote_path, :local_path ]
  end
  
  def self.default_source_type #:nodoc:
    "SingleFile"
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
  
  def self.default_remote_path #:nodoc:
    "/path/to/remote/target/file"
  end
  
  def self.default_local_path #:nodoc:
    "/path/to/local/blanket"
  end
    
  def remote_backup_path #:nodoc:
    remote_path
  end
  
  def local_backup_path #:nodoc:
    local_path
  end
  
  def prep_command #:nodoc:
    noop
  end
  
  def cleanup_command #:nodoc:
    noop
  end
  
end