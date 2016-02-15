require 'test_helper'

describe RocketModel::Attribute do

  subject do
    klass = Class.new { include RocketModel::Base }
    klass.attribute :name
    klass.new
  end

  it "returns self" do
    klass = Class.new { include RocketModel::Base }
    assert_equal klass.attribute(:name), klass
  end

  it "creates methods by given attribute name" do
    assert subject.respond_to?(:name)
    assert subject.respond_to?(:name=)
  end

  it "#attributes= accepts a hash for mass-assignment" do
    assert_equal subject.attributes={name: "Jony"}, {name: "Jony"}
  end

  it "#attributes returns attributes hash" do
    assert_equal subject.attributes, {name: nil}
    subject.attributes = {name: "Stefan"}
    assert_equal subject.attributes, {name: "Stefan"}
  end

  it "raises error when #attribute is a reserved wrong name" do
    klass = Class.new { include RocketModel::Base }
    exception = assert_raises(ArgumentError) { klass.attribute(:attributes) }
    assert_equal exception.message, ":attributes is not allowed as an attribute name"
  end

  it "raises error when attributes mass-assignment with unknown attribute" do
    exception = assert_raises(RocketModel::UnknownAttributeError) { subject.attributes = {unknown: 1} }
    assert_equal exception.message, "unknown attribute 'unknown' for #{subject.class}."
  end

  it "allows mass-assignment in constructor" do
    klass = Class.new { include RocketModel::Base }
    klass.attribute :name
    instance = klass.new name: "Jonny"
    assert_equal instance.name, "Jonny"
  end
end
