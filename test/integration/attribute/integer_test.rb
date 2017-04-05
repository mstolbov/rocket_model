require 'test_helper'

describe RocketModel::Attribute do

  describe "with integer type" do
    subject do
      klass = Class.new(RocketModel::Base) do
        attribute :round, :Integer
      end
      klass.new
    end

    it "converts attribute value to described type" do
      subject.round = 22.03
      assert_equal subject.round, 22
    end

    it "raises error when value cannot be converted" do
      exception = assert_raises(TypeError) { subject.round = :syml }
      assert_equal exception.message, "can't convert Symbol into RocketModel::Attribute::Integer"
    end
  end
end
