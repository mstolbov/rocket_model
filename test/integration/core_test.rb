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
    klass = Class.new(RocketModel::Base) do
      attribute :name, :String, default: "Bill"
    end
    klass.new
  end

  it "#inspect class" do
    assert_equal "#{subject.class}(name:String, id:Integer)", subject.class.inspect
  end

  it "#inspect instance" do
    assert_equal "#<#{subject.class} name: \"Bill\", id: nil>", subject.inspect
  end

  it "#configure" do
    RocketModel::Base.configure do |c|
      c.store = {store: "test", message: "Aloha!"}
    end
    klass = Class.new(RocketModel::Base)
    assert_equal RocketModel::Store::Test, klass.store.class
    assert_equal "Aloha!", klass.store.message

    #return dafault
    RocketModel::Base.configure do |c|
      c.store = {store: "file", path: "test/fixtures/test.pstore"}
    end
  end

  it "#configure default" do
    assert_equal RocketModel::Store::File, subject.class.store.class
  end

  it "sets store for model" do
    klass = Class.new(RocketModel::Base)
    klass.store = {store: "test", message: "Aloha!"}
    assert_equal RocketModel::Store::Test, klass.store.class
    assert_equal "Aloha!", klass.store.message
  end


end
