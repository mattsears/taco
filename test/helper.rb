require 'minitest/autorun'
require 'minitest/pride'
require 'mocha'
require 'awesome_print'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'taco'

def setup_files
  Taco::Config.any_instance.stubs(:file).returns(File.join(File.dirname(__FILE__), "examples/taco_config"))
  Taco::Storage::Yaml.any_instance.stubs(:file).returns( File.join(File.dirname(__FILE__), "examples/tacos"))
end

def setup_list
  list = Taco::List.new
  list.clear!
  list.add 'Take the dog for a walk'
  list.add 'Pay lease bill @work'
  list.add 'Buy Duck Typing from RubyRags @home'
  list.add 'Buy Ruby Nerd from RubyRags @home'
  list
end

