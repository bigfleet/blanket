gem 'blanket'
require 'blanket/init'
Capistrano::Configuration.instance(:must_exist).load do
  namespace :source do
  
    desc "Load configuration into Capistrano"
    task :load_config do
      reader = Blanket::Reader.new(FileUtils.pwd+"/source.yml")
      reader.keys.each do |key|
        set key.to_sym, reader.send(key)
      end
      set :source, Object.const_get(source_type).new(reader)
    end
  
    desc "Prepare a backup for download"
    task :prep, :hosts => lambda{ host } do
      run variables[:source].prep_command
    end
  
    desc "Download the prepped backup"
    task :download, :hosts => lambda{ host } do
      get variables[:source].remote_backup_path, variables[:source].local_backup_path
    end
  
    desc "Clean up, remotely"
    task :cleanup, :hosts => lambda{ host } do
      run variables[:source].cleanup_command
    end
  
  end
  before "source:prep", "source:load_config"
  before "source:download", "source:prep"
  after "source:download", "source:cleanup"

  namespace :sink do
  
    desc "Load configuration into Capistrano"
    task :load_config do
      reader = Blanket::Reader.new(FileUtils.pwd+"/sink.yml")
      reader.keys.each do |key|
        set key.to_sym, reader.send(key)
      end
      set :sink, Object.const_get(sink_type).new(reader)
    end
  
    desc "Send file to sink"
    task :export do
      upload_filename = Pathname.new(variables[:source].local_backup_path).basename.to_s
      variables[:sink].drain(bucket, upload_filename)
    end
    
    desc "SCP file out"
    task :scp, :hosts => lambda{ host } do
      put variables[:source].remote_backup_path, variables[:sink].remote_path
    end
  
  end
  before "sink:export", "source:download"
  before "sink:export", "sink:load_config"
  before "sink:scp", "source:download"
  before "sink:scp", "sink:load_config"
end