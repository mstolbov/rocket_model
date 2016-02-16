require 'test_helper'

describe RocketModel::Attribute do

  describe "with boolean type" do
    subject do
      klass = Class.new { include RocketModel::Base }
      klass.attribute :admin, :Boolean
      klass.new
    end

    it "converts attribute value to described type" do
      subject.admin = "yes"
      assert_equal subject.admin, true

      subject.admin = 0
      assert_equal subject.admin, false
    end

    it "raises error when value cannot be converted" do
      exception = assert_raises(TypeError) { subject.admin = 333 }
      assert_equal exception.message, "can't convert Fixnum into RocketModel::Attribute::Boolean"

      exception = assert_raises(TypeError) { subject.admin = "unknown" }
      assert_equal exception.message, "can't convert String into RocketModel::Attribute::Boolean"
    end
  end
end
