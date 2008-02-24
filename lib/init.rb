require 'rubygems'
require 'yaml'
require 'net/ssh'
gem 'aws-s3'

load File.dirname(__FILE__) + "/config/reader.rb"
load File.dirname(__FILE__) + "/config/writer.rb"
load File.dirname(__FILE__) + "/../plugins/sources/confluence.rb"