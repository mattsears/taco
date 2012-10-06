require_relative 'helper'

describe Taco::Item do

  before do
    @item = Taco::Item.new('New todo item @home')
  end

  it 'assigns a text value for the todo' do
    @item.text.must_equal 'New todo item'
  end

  it 'assigns a context from the todo value' do
    @item.context.must_equal '@home'
  end

end
