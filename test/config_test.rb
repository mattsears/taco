$:.unshift File.dirname(__FILE__)
require 'helper'

describe Taco::Config do

  before do
    Taco::Config.any_instance.stubs(:file).returns("test/examples/taco_config")
    @config = Taco::Config.new
  end

  it "gets a value with a key" do
    @config[:storage].must_equal "file"
  end

  it 'can get a value with the Taco module ' do
    Taco.config[:storage].must_equal "file"
  end

  it 'can save attributes to disk' do
    @config[:foo] = 'bar'
    @config.load_attributes
    Taco.config[:foo].must_equal 'bar'
  end

end
