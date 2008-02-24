require 'rubygems'
require 'yaml'
require 'net/ssh'
gem 'aws-s3'

# God, this is laborious.  I need to know how to do this better.

require File.dirname(__FILE__) + "/utils.rb"
require File.dirname(__FILE__) + "/config/reader.rb"
require File.dirname(__FILE__) + "/config/writer.rb"
require File.dirname(__FILE__) + "/runner.rb"
require File.dirname(__FILE__) + "/sink.rb"
require File.dirname(__FILE__) + "/source.rb"
require File.dirname(__FILE__) + "/../plugins/sources/confluence.rb"
require File.dirname(__FILE__) + "/../plugins/sinks/s3.rb"
