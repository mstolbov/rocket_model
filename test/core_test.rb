require 'test_helper'

describe RocketModel::Core do

  subject do
    klass = Class.new { include RocketModel }
    klass.attribute :name, :String, default: "Bill"
    klass.new
  end

  it "#inspect class" do
    assert_equal "#{subject.class}(name:String)", subject.class.inspect
  end

  it "#inspect instance" do
    assert_equal "#<#{subject.class} name: \"Bill\">", subject.inspect
  end

  it "#configure"


end
