
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
    puts "Executing #{cmd}"
    #exec(cmd)
  end
  
  desc "Clean up, remotely"
  task :cleanup do
    puts "[source:cleanup] begin"
  end
  
end
before "source:prep", "source:load_config"
before "source:download", "source:load_config"
after "source:prep", "source:download"
after "source:download", "source:cleanup"

namespace :sink do
  
  desc "Load configuration into Capistrano"
  task :load_config do
    puts "[sink:load_config] begin"
    reader = Reader.new(File.dirname(__FILE__)+"/sink.yml")
    reader.keys.each do |key|
      # load each key into Capistrano
      set key.to_sym, reader.send(key)
    end
    set :sink_reader, reader
  end
  
  desc "Send file to sink"
  task :export do
    puts "[sink:export] begin"
    s3 = S3.new(sink_reader)
    puts "#{bucket}, #{backup_file}"
    s3.drain(bucket, backup_file)
  end
  
end
before "sink:load_config", "source:download"
before "sink:export", "sink:load_config"