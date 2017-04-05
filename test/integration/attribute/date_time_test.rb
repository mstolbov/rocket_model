require 'test_helper'

describe RocketModel::Attribute do

  describe "with date type" do
    subject do
      klass = Class.new(RocketModel::Base) do
        attribute :datetime, :DateTime
      end
      klass.new
    end

    it "converts attribute value to described type" do
      subject.datetime = "2016-02-01 12:01:01"
      assert_equal subject.datetime, ::DateTime.parse("2016-02-01 12:01:01")
    end

    it "raises error when value cannot be converted" do
      exception = assert_raises(TypeError) { subject.datetime = :syml }
      assert_equal exception.message, "can't convert Symbol into RocketModel::Attribute::DateTime"
    end
  end
end
