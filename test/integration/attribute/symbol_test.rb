require 'test_helper'

describe RocketModel::Attribute do

  describe "with symbol type" do
    subject do
      klass = Class.new(RocketModel::Base) do
        attribute :name, :Symbol
      end
      klass.new
    end

    it "converts attribute value to described type" do
      subject.name = "22.03"
      assert_equal subject.name, :"22.03"
    end

    it "raises error when value cannot be converted" do
      exception = assert_raises(TypeError) { subject.name = 3333 }
      assert_equal exception.message, "can't convert Fixnum into RocketModel::Attribute::Symbol"
    end
  end
end
