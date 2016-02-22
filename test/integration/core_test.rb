require 'test_helper'

module RocketModel
  module Store
    class Test
      attr_reader :message

      def initialize(message:)
        @message = message
      end
    end
  end
end

describe RocketModel::Core do

  subject do
    klass = Class.new { include RocketModel }
    klass.attribute :name, :String, default: "Bill"
    klass.new
  end

  it "#inspect class" do
    assert_equal "#{subject.class}(id:Integer, name:String)", subject.class.inspect
  end

  it "#inspect instance" do
    assert_equal "#<#{subject.class} id: nil, name: \"Bill\">", subject.inspect
  end

  it "#configure" do
    RocketModel.config do |c|
      c.store = {store: "test", message: "Aloha!"}
    end
    klass = Class.new { include RocketModel }
    assert_equal RocketModel::Store::Test, klass.store.class
    assert_equal "Aloha!", klass.store.message

    #return dafault
    RocketModel.config do |c|
      c.store = {store: "file", path: "test.pstore"}
    end
  end

  it "#configure default" do
    assert_equal RocketModel::Store::File, subject.class.store.class
  end

  it "sets store for model" do
    klass = Class.new { include RocketModel }
    klass.store = {store: "test", message: "Aloha!"}
    assert_equal RocketModel::Store::Test, klass.store.class
    assert_equal "Aloha!", klass.store.message
  end


end
