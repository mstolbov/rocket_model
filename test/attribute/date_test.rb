require 'test_helper'

describe RocketModel::Attribute do

  describe "with date type" do
    subject do
      klass = Class.new { include RocketModel }
      klass.attribute :date, :Date
      klass.new
    end

    it "converts attribute value to described type" do
      subject.date = "2016-02-01"
      assert_equal subject.date, ::Date.parse("2016-02-01")
    end

    it "raises error when value cannot be converted" do
      exception = assert_raises(TypeError) { subject.date = 333 }
      assert_equal exception.message, "can't convert Fixnum into RocketModel::Attribute::Date"
    end
  end
end
