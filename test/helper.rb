require "bundler"
Bundler.setup

require 'minitest/autorun'
require 'minitest/pride'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'taco'