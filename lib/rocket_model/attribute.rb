module RocketModel
  module Attribute

    def self.included(base)
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
        validate_name(name)
        @attribute_definitions << [name]
        self
      end

      def validate_name(name)
        if instance_methods.include?(:attributes) && name.to_sym == :attributes
          fail ArgumentError, "#{name.inspect} is not allowed as an attribute name"
        end
      end
      private :validate_name
    end

    def initialize(args = {})
      define_attributes
    end

    def attributes
      values = {}
      attribute_definitions.each do |attribute_args|
        name, _ = *attribute_args
        values[name] = public_send(name)
      end
      values
    end

    def attributes=(values)
      values.each do |name, value|
        writer_name = "#{name}="
        if respond_to?(writer_name)
          public_send writer_name, value
        else
          fail UnknownAttributeError.new(self, name)
        end
      end
    end

    def define_attributes
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

    def attribute_definitions
      @attribute_definitions ||= self.class.instance_variable_get("@attribute_definitions")
    end
    private :attribute_definitions

  end
end
