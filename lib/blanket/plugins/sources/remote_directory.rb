# Source for backing up single remote directory.
#
# Create a RemoteDirectory source by running <code>blanket-cfg</code> with the
# <code>-o RemoteDirectory</code> option.  Your directory will be compressed
# using a <code>tar</code> and <code>gzip</code> command. 
# 
# In the source.yml file, set the following options:
#
# [user] Username on the remote system.
# [password] Password on the remote system.
# [host] Domain name of the remote system.
# [remote_directory] The location on the remote server you'd like to blanket.  <strong>You will need write access in the parent directory.</strong>
# [local_path] The location on client running the blanket where the database backup is stored before being sent to a sink.
#
# That's right, <code>tar</code> and <code>gz</code>.  If you want something else, write a ticket, or
# better yet, implement it.

class RemoteDirectory < Source
  
  def initialize(reader) #:nodoc:
    @reader = reader
  end
  
  def self.attribute_symbols #:nodoc:
    [:source_type, :host, :user, :password, :remote_directory, :local_path ]
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
    "/path/to/remote/target/directory"
  end
  
  def self.default_local_path #:nodoc:
    "/path/to/local/blanket"
  end
  
  # Determines the file that will be downloaded by blanket. 
  def remote_backup_path #:nodoc:
    full_tarfile+".gz"
  end
  
  # The path on the client filesystem where the backup file resides after
  # downloading from the source.  Right now, there is only good support
  # for having this path within your blanket task directory itself.
  # [http://bigfleet.lighthouseapp.com/projects/8764/tickets/4-remove-task-directory-dependence-for-storing-backup-file-on-client]
  def local_backup_path #:nodoc:
    local_path
  end
  
  # Determines the name of the directory that needs to be tarred on the
  # remote system.
  def tar_directory #:nodoc:
    rp = Pathname.new(remote_directory)
    rp.dirname.to_s
  end
  
  # Determines the name of the tarfile that will be created remotely.
  def tarfile #:nodoc:
    rp = Pathname.new(remote_directory)    
    rp.basename.to_s+".tar"
  end
  
  # Determines the full filename of the the tarfile on the remote system.
  def full_tarfile #:nodoc:
    [tar_directory, tarfile].join("/")
  end
  
  # Create the tarfile and compress the results.  The <code>-f</code>
  # option overwrites any previous file, if it exists.
  def prep_command #:nodoc:
    "tar cvf #{full_tarfile} #{remote_directory}; gzip -f #{full_tarfile}"
  end
  
  # Planned for implementation
  def cleanup_command #:nodoc:
    noop
  end
  
end