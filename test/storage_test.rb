$:.unshift File.dirname(__FILE__)
require 'helper'

describe Taco::Storage do

  before do
    Taco::Storage.backend = :yaml
  end

  it 'returns a File class' do
    Taco::Storage.backend.must_be_kind_of Taco::Storage::Yaml
  end

end
