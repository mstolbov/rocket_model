require 'test_helper'

describe RocketModel::Attribute do

  it "returns self" do
    klass = Class.new { include RocketModel::Base }
    assert_equal klass.attribute(:name), klass
  end

  it "creates methods by given attribute name" do
    klass = Class.new { include RocketModel::Base }
    klass.attribute :name
    instance = klass.new
    assert instance.respond_to?(:name)
    assert instance.respond_to?(:name=)
  end
end
