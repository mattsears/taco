require_relative 'helper'

describe Taco::List do

  before do
    setup_files
    @list = setup_list
  end

  it "adds the todo to the stack" do
    @list.items.size.must_equal 4
  end

  it 'assigns a default tag unless provided' do
    @list.items.first.context.must_equal '@'
  end

  it "creates a hash of attributes from the todo items" do
    Taco.storage.to_hash.must_equal({
        :"@" => ["Take the dog for a walk"],
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
    @list.done(3).context.must_equal "@done"
  end

  it 'should move the specific item to the top' do
    @list.bump(3)
    @list.items.first.text.must_equal 'Buy Duck Typing from RubyRags'
  end

end
