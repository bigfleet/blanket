# A Sink that (indirectly uses the <code>sftp</code> command on your system
# to upload a backup to a remote SFTP server, such as Joyent StrongSpace.
#
# The SFTP support is borrowed entirely from Capistrano, so I am not
# totally certain what to say if you run into trouble.
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
  
  def self.default_sink_type
    "Sftp"
  end
  
  def self.default_host
    "yourhost.com"
  end
  
  # Your username on the remote system.
  def self.default_user
    "username"
  end

  # Your password for the remote system.  May not be needed if you have
  # set up SSH keys.  
  def self.default_password
    "password"
  end

  # The path on the remote filesystem that you want to SCP the file.  You
  # may have success with relative paths, but I haven't.  
  def self.default_remote_path
    "/path/to/remote/backup/directory"
  end
  
  # The path on the client filesystem where the backup file resides after
  # downloading from the source.  Right now, there is only good support
  # for having this path within your blanket task directory itself.
  # See http://bigfleet.lighthouseapp.com/projects/8764/tickets/4-remove-task-directory-dependence-for-storing-backup-file-on-client
  def self.default_local_path
    "/path/to/local/blanket"
  end
  
  # Not sure how this will be used yet, planned for a part of an 
  # upcoming release.
  def cleanup_command
    noop
  end
  
end