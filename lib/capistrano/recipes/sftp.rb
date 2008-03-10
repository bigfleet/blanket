gem 'blanket'
require 'blanket/init'
Capistrano::Configuration.instance(:must_exist).load do

  namespace :sink do
      
    desc "Upload file to S3"
    task :export do
      puts "Uploading #{variables[:source].local_backup_path} to #{variables[:sink].remote_path}"
      Net::SFTP.start(host, user, password) do |sftp|
        sftp.put_file variables[:source].local_backup_path, variables[:sink].remote_path
      end
    end
  
  end
end


