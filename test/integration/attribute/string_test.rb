require 'test_helper'

describe RocketModel::Attribute do

  describe "with string type" do
    subject do
      klass = Class.new(RocketModel::Base) do
        attribute :name, :String
      end
      klass.new
    end

    it "converts attribute value to described type" do
      subject.name = :Anton
      assert_equal subject.name, "Anton"
    end

    it "raises error when value cannot be converted" do
      value = Class.new.new
      exception = assert_raises(TypeError) { subject.name = value }
      assert_equal exception.message, "can't convert #{value.class} into RocketModel::Attribute::String"
    end
  end
end
