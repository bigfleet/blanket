
require File.dirname(__FILE__)+"/../lib/init.rb"
namespace :source do
  
  desc "Load configuration into Capistrano"
  task :load_config do
    reader = Reader.new(File.dirname(__FILE__)+"/source.yml")
    reader.keys.each do |key|
      # load each key into Capistrano
      puts "setting #{key} to #{reader.send(key)}"
      set key.to_sym, reader.send(key)
    end
  end
  
  desc "Prepare a backup for download"
  task :prep, :hosts => lambda{ host } do
    run "mysqldump #{dump_options} --password=#{password} -u #{db_user}  #{database} > #{backup_file}"
  end
  
  desc "Download the prepped backup"
  task :download, :hosts => lambda{ host } do
    get backup_file, FileUtils.pwd+"/#{filename}"
  end
  
  desc "Clean up, remotely"
  task :cleanup do
  end
  
end
before "source:prep", "source:load_config"
before "source:download", "source:prep"
after "source:download", "source:cleanup"

namespace :sink do
  
  desc "Load configuration into Capistrano"
  task :load_config do
    reader = Reader.new(File.dirname(__FILE__)+"/sink.yml")
    reader.keys.each do |key|
      # load each key into Capistrano
      set key.to_sym, reader.send(key)
    end
    set :sink_reader, reader
  end
  
  desc "Send file to sink"
  task :export do
    s3 = S3.new(sink_reader)
    s3.drain(bucket, filename)
  end
  
end
before "sink:export", "source:download"
before "sink:export", "sink:load_config"