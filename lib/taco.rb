require 'optparse'
require 'yaml'
require 'taco/command'
require 'taco/item'
require 'taco/list'
require "taco/version"

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

#
# == Taco Module
#
# A simple command-line app that manages todo items
#
module Taco
  extend self
end
