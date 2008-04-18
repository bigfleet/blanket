# Source for backing up Subversion repository.
#
# Create a Subversion source by running <code>blanket-cfg</code> with the
# <code>-o Subversion</code> option.  Your directory will be compressed
# using a <code>tar</code> and <code>gzip</code> command. 
# 
# In the source.yml file, set the following options:
#
# [user] Username on the remote system.
# [password] Password on the remote system.
# [host] Domain name of the remote system.
# [repository] Remote directory containing the repository
# [remote_path] The name of the file on the remote machine you'd like the repository to be backed up to.
# [local_path] The location on client running the blanket where the database backup is stored before being sent to a sink.
#
class Subversion < Source
  
  def initialize(reader) #:nodoc:
    @reader = reader
  end
  
  def self.attribute_symbols #:nodoc:
    [:source_type, :host, :user, :password, :repository, :remote_path, :local_path ]
  end
  
  def self.default_source_type #:nodoc:
    "Subversion"
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
  
  def self.default_repository #:nodoc:
    "/path/to/repo"
  end
  
  def self.default_remote_path #:nodoc:
    "/path/to/remote/backup-file"
  end
  
  def self.default_local_path #:nodoc:
    "/path/to/local/backup-file"
  end
    
  def remote_backup_path #:nodoc:
    remote_path
  end
  
  def local_backup_path #:nodoc:
    local_path
  end
  
  def prep_command #:nodoc:
    "svnadmin dump #{repository} > #{remote_backup_path}"
  end
  
  # Ugh, tired of not having these things written!
  def cleanup_command #:nodoc:
    noop
  end
  
end