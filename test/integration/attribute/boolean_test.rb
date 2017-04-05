require 'test_helper'

describe RocketModel::Attribute do

  describe "with boolean type" do
    subject do
      klass = Class.new(RocketModel::Base) do
        attribute :admin, :Boolean
      end
      klass.new
    end

    it "converts attribute value to described type" do
      subject.admin = "yes"
      assert_equal true, subject.admin

      subject.admin = 0
      assert_equal false, subject.admin
    end

    it "raises error when value cannot be converted" do
      exception = assert_raises(TypeError) { subject.admin = 333 }
      assert_equal exception.message, "can't convert Fixnum into RocketModel::Attribute::Boolean"

      exception = assert_raises(TypeError) { subject.admin = "unknown" }
      assert_equal exception.message, "can't convert String into RocketModel::Attribute::Boolean"
    end
  end
end
