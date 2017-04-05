require 'test_helper'

describe RocketModel::DirtyAttribute do

  subject do
    klass = Class.new(RocketModel::Base) do
      attribute :name
      attribute :kind, :Symbol, default: :man
    end
    klass.new
  end

  it "default value isn't dirty" do
    assert_equal :man, subject.kind
    assert !subject.changed?
  end

  it "marks attributes in constructor as dirty" do
    klass = Class.new(RocketModel::Base) do
      attribute :name
      attribute :kind, :Symbol, default: :man
    end
    obj = klass.new name: "Joan", kind: :woman
    assert_equal ["name", "kind"], obj.changed
  end

  it "don't marks attribute as dirty if incoming value the same" do
    subject.kind = :man
    assert !subject.changed?
  end

  it "returns attribute changes" do
    subject.kind = :woman
    subject.name = "Joan"
    assert_equal({"name" => [nil, "Joan"], "kind" => [:man, :woman]}, subject.changes)
  end

  it "returns previous attribute value" do
    subject.kind = :woman
    subject.name = "Joan"
    assert_equal nil, subject.previous_value(:name)
    assert_equal :man, subject.previous_value(:kind)
  end

  it "#changes_applied" do
    subject.kind = :woman
    subject.name = "Joan"
    subject.changes_applied
    assert !subject.changed?
  end

  it "restore_attributes" do
    subject.kind = :woman
    subject.name = "Joan"
    assert subject.changed?
    assert_equal({"id" => nil, "name" => "Joan", "kind" => :woman}, subject.attributes)

    subject.restore_attributes
    assert !subject.changed?
    assert_equal({"id" => nil, "name" => nil, "kind" => :man}, subject.attributes)
  end
end
