gem 'aws-s3'

# Sink for uploading backup material to Amazon's S3 Service
#
# When using <code>blanket-cfg</code> with the <code>-i S3</code> argument,
# you'll need to supply the correct details for the following attributes
# in the sink.yml file.
#
# 
# [access_key_id] Your ID from your Amazon Web Services Account
# [secret_access_key] The "password" equivalent, you have to click on an on-screen control to access this
# [bucket] The name of the bucket to which you will upload the backup.  The default is "s3-bucket".  You don't have to supply this value, but you probably should
#
# After supplying this data and configuring your Sink, you should be able to
# use the <code>blanket</code> command to test your configuration.
class S3 < Sink
  
  include AWS::S3
  
  attr_accessor :reader
  
  def initialize(reader) #:nodoc:
    @reader = reader
  end
  
  # additional requirements needed for the Capfile in order to use
  # the correct recipes.  You probably won't need to change this.
  def self.additional_requirements #:nodoc:
    "'capistrano/recipes/s3'"
  end
  
  def self.attribute_symbols #:nodoc:
    [:access_key_id, :secret_access_key, :sink_type, :bucket]
  end
  
  def self.default_sink_type #:nodoc:
    "S3"
  end
    
  def self.default_access_key_id #:nodoc:
    "your-id"
  end
  
  def self.default_secret_access_key #:nodoc:
    "your-secret-ket"
  end
  
  def self.default_bucket #:nodoc:
    "s3-bucket"
  end
  
  # finds the bucket to use on the S3 side.  If the bucket is
  # not found, it will be created.
  def find_bucket(bucket)
    begin
      Bucket.find(bucket) 
    rescue NoSuchBucket
      S3.create_bucket(bucket)
      find_bucket(bucket)
    end
  end
  
  # creates an S3 bucket of a specified name
  def self.create_bucket(name)
    Bucket.create(name)
  end
  
  # opens the connection to the S3 service
  def open_connection
    AWS::S3::Base.establish_connection!(
        :access_key_id     => @reader.access_key_id,
        :secret_access_key => @reader.secret_access_key
    )
  end
  
  def log(msg, lvl) #:nodoc:
    puts msg
  end
  
  # performs the act of uploading the backup file to S3.  If a
  # file of the same name exists on the remote system, it will
  # be overwritten with the new file you supply.
  def drain(bucket, backup_file)
    open_connection
    s3_bucket = find_bucket(bucket)
    if s3_bucket[backup_file]
      log("Removing existing #{backup_file}", :info)
      S3Object.delete(backup_file.to_s, bucket)
    end
      log("Uploading #{backup_file} to S3", :info)
      S3Object.store(backup_file.to_s, File.open(backup_file), bucket)
  end
  
end