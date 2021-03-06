require 'test_helper'
require 'yaml'

describe RocketModel::Serialization do

  subject do
    klass = Class.new do
      include RocketModel::Serialization
      def attributes
        {
          name: "Bill",
          kind: :man
        }.stringify_keys
      end

      def name
        attributes["name"]
      end

      def kind
        attributes["kind"]
      end
    end
    klass.new
  end

  it "has #to_json method" do
    assert subject.respond_to?(:to_json)
  end

  it "has #to_yaml method" do
    assert subject.respond_to?(:to_yaml)
  end

  it "represents only gived attributes" do
    json_str = {"name" => "Bill"}.to_json
    assert_equal json_str, subject.to_json(only: :name)
  end

  it "represents except gived attributes" do
    json_str = {"kind" => :man}.to_yaml
    assert_equal json_str, subject.to_yaml(except: :name)
  end

end
