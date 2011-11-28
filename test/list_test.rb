$:.unshift File.dirname(__FILE__)
require 'helper'

describe Taco::List do

  before do
    Taco::List.any_instance.stubs(:file).returns("test/examples/tacos")
    @list = Taco::List.new
    @list.clear!
    @list.add 'Take the dog for a walk'
    @list.add 'Pay lease bill @work'
    @list.add 'Buy Duck Typing from RubyRags @home'
    @list.add 'Buy Ruby Nerd from RubyRags @home'
  end

  it "finds the file path of the todo list" do
    @list.file.must_equal 'test/examples/tacos'
  end

  it "adds the todo to the stack" do
    @list.items.size.must_equal 4
  end

  it "creates a hash of attributes from the todo items" do
    Taco.storage.to_hash.must_equal({
        :@next => ["Take the dog for a walk"],
        :@work => ["Pay lease bill"],
        :@home => ["Buy Duck Typing from RubyRags", "Buy Ruby Nerd from RubyRags"]
      })
  end

  it 'deletes a todo' do
    @list.delete(2).text.must_equal "Pay lease bill"
    @list.items.size.must_equal 3
  end

  it 'completes a todo' do
    @list.done(2).context.must_equal "@done"
  end


  it 'should move the specific item to the top' do
    @list.bump(3)
    @list.items.first.text.must_equal 'Buy Duck Typing from RubyRags'
  end

end
