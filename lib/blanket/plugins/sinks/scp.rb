# A Sink that uses the <code>scp</code> command on your system to upload
# a backup to a remote filesystem capable of receiving SCP requests.
#
# This means that the client machine is either OS X, *nix, or a cleverly
# modified Windows machine.  The remote machine is almost certainly not
# Windows, but YMMV.
#
# Using this sink will ultimately yield a command similar to:
# <code>scp <local_path> <host>:<remote_path></code>
#
# When using <code>blanket-cfg</code> with the <code>-o Scp</code> argument,
# you'll need to supply the correct details for the following attributes
# in the source.yml file.
#
# [user] Username on the remote system.
# [password] Password on the remote system.
# [host] Domain name of the remote system.
# [remote_path] The path on the remote system that you'd like to upload the blanket to.
# [local_path] The location on client running the blanket where the database backup is stored before being sent to a sink.


class Scp < Sink
  
  def initialize(reader) #:nodoc:
    @reader = reader
  end
  
  def self.attribute_symbols #:nodoc:
    [:sink_type, :host, :user, :password, :remote_path, :local_path ]
  end
  
  def self.default_sink_type #:nodoc:
    "Scp"
  end
  
  def self.default_host #:nodoc:
    "yourhost.com"
  end
  
  # Your username on the remote system.
  def self.default_user #:nodoc:
    "username"
  end
  
  # Your password for the remote system.  May not be needed if you have
  # set up SSH keys.
  def self.default_password #:nodoc:
    "password"
  end
  
  # The path on the remote filesystem that you want to SCP the file.  You
  # may have success with relative paths, but I haven't.
  def self.default_remote_path #:nodoc:
    "/path/to/remote/backup/directory"
  end
  
  # The path on the client filesystem where the backup file resides after
  # downloading from the source.  Right now, there is only good support
  # for having this path within your blanket task directory itself. See the ticket.
  # [http://bigfleet.lighthouseapp.com/projects/8764/tickets/4-remove-task-directory-dependence-for-storing-backup-file-on-client]
  def self.default_local_path #:nodoc:
    "/path/to/local/blanket"
  end
  
  # Not sure how this will be used yet, planned for a part of an 
  # upcoming release.
  def cleanup_command #:nodoc:
    noop
  end
  
end