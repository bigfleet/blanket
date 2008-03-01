
require File.dirname(__FILE__)+"/../lib/init.rb"
namespace :source do
  
  desc "Load configuration into Capistrano"
  task :load_config do
    reader = Reader.new(File.dirname(__FILE__)+"/source.yml")
    reader.keys.each do |key|
      # load each key into Capistrano
      set key.to_sym, reader.send(key)
    end
    set :backup_file, Confluence.backup_file
  end
  
  desc "Prepare a backup for download"
  task :prep do
    # none needed for Confluence
  end
  
  desc "Download the prepped backup"
  task :download do
    cmd = "scp #{host}:#{directory}/#{Confluence.backup_file} ."
    system(cmd)
  end
  
  desc "Clean up, remotely"
  task :cleanup do
  end
  
end
before "source:prep", "source:load_config"
before "source:download", "source:load_config"
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
    s3.drain(bucket, backup_file)
  end
  
end
before "sink:export", "source:download"
before "sink:export", "sink:load_config"