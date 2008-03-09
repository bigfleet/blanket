require 'rubygems'
require 'yaml'
gem 'aws-s3'
gem 'rake'
gem 'capistrano'
require 'rake'
require 'capistrano'
require 'aws/s3'
require 'pathname'

root = File.dirname(__FILE__)

require File.join(root, "utils.rb")
require File.join(root, "config", "reader.rb")
require File.join(root, "config", "writer.rb")
require File.join(root, "sink.rb")
require File.join(root, "source.rb")

# Require all sources and sinks
sources_directory = File.join(root, 'plugins', 'sources')
sink_directory    = File.join(root, 'plugins', 'sinks')

[sources_directory, sink_directory].each do |directory|
  # select only files ending in .rb
  Dir.new(directory).select{|file| file =~ /\.rb/}.each do |source|
    require File.join(directory, source)
  end
end
