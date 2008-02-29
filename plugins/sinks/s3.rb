gem 'aws-s3'
class S3 < Sink
  
  include AWS::S3
  
  attr_accessor :reader
  
  def initialize(reader)
    @reader = reader
  end
  
  def self.attribute_symbols
    [:access_key_id, :secret_access_key, :sink_type, :bucket]
  end
  
  def self.default_sink_type
    "S3"
  end
    
  def self.default_access_key_id
    "your-id"
  end
  
  def self.default_secret_access_key
    "your-secret-ket"
  end
  
  def self.default_bucket
    "s3-bucket"
  end
  
  def find_bucket(bucket)
    begin
      Bucket.find(bucket) 
    rescue NoSuchBucket
      S3.create_bucket(bucket)
      find_bucket(bucket)
    end
  end
  
  def self.create_bucket(name)
    Bucket.create(name)
  end
  
  def open_connection
    AWS::S3::Base.establish_connection!(
        :access_key_id     => @reader.access_key_id,
        :secret_access_key => @reader.secret_access_key
    )
  end
  
  def log(msg, lvl)
    puts msg
  end
  
  def drain(bucket, backup_file)
    open_connection
    s3_bucket = find_bucket(bucket)
    if s3_bucket[backup_file]
      log("Skipping #{backup_file} as it is already in S3", :info)
    else
      log("Uploading #{backup_file} to S3", :info)
      S3Object.store(backup_file.to_s, File.open(backup_file), bucket)
    end
  end
  
end