require 'test_helper'

describe RocketModel::Attribute do

  describe "with float type" do
    subject do
      klass = Class.new { include RocketModel }
      klass.attribute :round, :Float
      klass.new
    end

    it "converts attribute value to described type" do
      subject.round = "22.03"
      assert_equal subject.round, 22.03
    end

    it "raises error when value cannot be converted" do
      exception = assert_raises(TypeError) { subject.round = :syml }
      assert_equal exception.message, "can't convert Symbol into RocketModel::Attribute::Float"
    end
  end
end
