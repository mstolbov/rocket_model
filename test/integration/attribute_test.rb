require 'test_helper'

describe RocketModel::Attribute do

  subject do
    klass = Class.new(RocketModel::Base) do
      attribute :name
    end
    klass.new
  end

  it "returns self" do
    klass = Class.new(RocketModel::Base)
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
    assert_equal({"id" => nil,"name" => nil}, subject.attributes)
    subject.attributes = {name: "Stefan"}
    assert_equal({"id" => nil, "name" => "Stefan"}, subject.attributes)
  end

  it "raises error when #attribute is a reserved wrong name" do
    klass = Class.new(RocketModel::Base)
    exception = assert_raises(ArgumentError) { klass.attribute(:attributes) }
    assert_equal exception.message, ":attributes is not allowed as an attribute name"
  end

  it "raises error when attributes mass-assignment with unknown attribute" do
    exception = assert_raises(RocketModel::UnknownAttributeError) { subject.attributes = {unknown: 1} }
    assert_equal exception.message, "unknown attribute 'unknown' for #{subject.class}."
  end

  it "allows mass-assignment in constructor" do
    klass = Class.new(RocketModel::Base) do
      attribute :name
    end
    obj = klass.new name: "Jonny"
    assert_equal obj.name, "Jonny"
  end

  describe "with type defined" do
    subject do
      klass = Class.new(RocketModel::Base) do
        attribute :name, String
      end
      klass.new
    end

    it "sets default value in initialize" do
      exception = assert_raises(ArgumentError) { subject }
      assert_equal exception.message, "String is not allowed as an attribute type"
    end

  end

  describe "with default values" do
    subject do
      klass = Class.new(RocketModel::Base) do
        attribute :name, :String, default: "Jonny Smith"
      end
      klass.new
    end

    it "sets default value in initialize" do
      assert_equal subject.name, "Jonny Smith"
    end

  end
end
