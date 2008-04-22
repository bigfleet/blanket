require 'rubygems'
require 'yaml'
gem 'aws-s3'
gem 'rake'
gem 'capistrano'
require 'rake'
require 'capistrano'
require 'aws/s3'
require 'pathname'

require "blanket/utils"
require "blanket/config/reader"
require "blanket/config/writer"
require 'blanket/sink'
require 'blanket/source'

root = File.join(File.dirname(__FILE__), "blanket")
# Require all sources and sinks
sources_directory = File.join(root, 'plugins', 'sources')
sink_directory    = File.join(root, 'plugins', 'sinks')

[sources_directory, sink_directory].each do |directory|
  # select only files ending in .rb
  Dir.new(directory).select{|file| file =~ /\.rb/}.each do |source|
    require File.join(directory, source)
  end
end

# Blanket: For making backup easier
#
# See a Blanket introduction[http://github.com/bigfleet/blanket/wikis] or
# a walkthrough[http://github.com/bigfleet/blanket/wikis/quickstart] of 
# setting up your first blanket.
module Blanket
end