gem 'blanket'
require 'blanket/init'
Capistrano::Configuration.instance(:must_exist).load do

  namespace :sink do
      
    desc "Upload file to S3"
    task :export do
      upload_filename = Pathname.new(variables[:source].local_backup_path).basename.to_s
      variables[:sink].drain(bucket, upload_filename)
    end
  
  end
end