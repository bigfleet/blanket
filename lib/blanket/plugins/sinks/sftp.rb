# A Sink that (indirectly uses the <code>sftp</code> command on your system
# to upload a backup to a remote SFTP server, such as Joyent StrongSpace.
#
# The SFTP support is borrowed entirely from Capistrano, so I am not
# totally certain what to say if you run into trouble.

#
# When using <code>blanket-cfg</code> with the <code>-o Sftp</code> argument,
# you'll need to supply the correct details for the following attributes
# in the sink.yml file.
#
# [host] Domain name of the remote system.
# [user] Username on the remote system.
# [password] Password on the remote system.
# [remote_path] The location on the remote server where the database backup file is stored temporarily. 
# [local_path] The location on client running the blanket where the database backup is stored before being sent to a sink.
#
# After supplying this data and configuring your Sink, you should be able to
# use the <code>blanket</code> command to test your configuration.

class Sftp < Sink
  
  def initialize(reader) #:nodoc:
    @reader = reader
  end
  
  # additional requirements for the Capfile to include in order to use
  # the appropriate Capistrano recipes.
  def self.additional_requirements
    "'capistrano/recipes/sftp'"
  end
  
  def self.attribute_symbols # :nodoc:
    [:sink_type, :host, :user, :password, :remote_path, :local_path ]
  end
  
  def self.default_sink_type #:nodoc:
    "Sftp"
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
    "/path/to/remote/backup/directory"
  end
  
  # The path on the client filesystem where the backup file resides after
  # downloading from the source.  Right now, there is only good support
  # for having this path within your blanket task directory itself.
  # [http://bigfleet.lighthouseapp.com/projects/8764/tickets/4-remove-task-directory-dependence-for-storing-backup-file-on-client]
  def self.default_local_path #:nodoc:
    "/path/to/local/blanket"
  end
  
  # Planned soon [http://bigfleet.lighthouseapp.com/projects/8764/tickets/11-rotation-cleanup-for-sftp]
  def cleanup_command #:nodoc:
    noop
  end
  
end