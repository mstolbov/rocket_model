module RocketModel
  module Attribute

    def self.included(base)
      super
      base.extend ClassMethods
      base.class_eval do
        setup
      end
    end

    module ClassMethods
      def setup
        @attribute_definitions = []
      end

      def attribute(name)
        @attribute_definitions << [name]
        self
      end
    end

    def initialize(args = {})
      define_attributes
    end

    def define_attributes
      attribute_definitions = self.class.instance_variable_get("@attribute_definitions")
      attribute_definitions.each do |attribute_args|
        name, _ = *attribute_args
        define_singleton_method name do
          instance_variable_get "@#{name}"
        end

        define_singleton_method "#{name}=" do |value|
          instance_variable_set "@#{name}", value
        end

      end
    end
    private :define_attributes

  end
end
