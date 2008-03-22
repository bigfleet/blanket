# A Sink that uses the <code>scp</code> command on your system to upload
# a backup to a remote filesystem capable of receiving SCP requests.
#
# This means that the client machine is either OS X, *nix, or a cleverly
# modified Windows machine.  The remote machine is almost certainly not
# Windows, but YMMV.
#
# Using this sink will ultimately yield a command similar to:
# <code>scp <local_path> <host>:<remote_path></code>
class Scp < Sink
  
  def initialize(reader) # :nodoc:
    @reader = reader
  end
  
  def self.attribute_symbols # :nodoc:
    [:sink_type, :host, :user, :password, :remote_path, :local_path ]
  end
  
  def self.default_sink_type
    "Scp"
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