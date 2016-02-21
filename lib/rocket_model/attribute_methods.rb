module RocketModel
  module AttributeMethods
    TYPES = [:Date, :DateTime, :Time, :Integer, :Float, :String, :Symbol, :Boolean]

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

      def attribute(name, type = nil, options = {})
        validate_name(name)
        validate_type(type) if type
        @attribute_definitions << [name, type, options]
        self
      end

      def inspect
        attr_list = @attribute_definitions.map do |name, type, _|
          "#{name}:#{type}"
        end.join(", ")
        "#{super}(#{attr_list})"
      end

      def validate_name(name)
        if instance_methods.include?(:attributes) && name.to_sym == :attributes
          fail ArgumentError, "#{name.inspect} is not allowed as an attribute name"
        end
      end
      private :validate_name

      def validate_type(type)
        if !TYPES.include?(type)
          fail ArgumentError, "#{type.inspect} is not allowed as an attribute type"
        end
      end
      private :validate_type
    end

    def initialize(args = {})
      define_attributes
      self.attributes = args
    end

    def attributes
      values = {}
      attribute_definitions.each do |attribute_args|
        name, _type, _options = *attribute_args
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

    def inspect
      inspect_attributes = attributes.map { |k, v| "#{k}: #{v.inspect}" }.join(", ")
      "#<#{self.class} #{inspect_attributes}>"
    end

    def define_attributes
      attribute_definitions.each do |attribute_args|
        define_attribute_methods(*attribute_args)
      end
    end
    private :define_attributes

    def define_attribute_methods(name, type, options)
      define_attribute_variable(name, type, options)

      define_singleton_method name do
        get_attribute_value(name)
      end

      writer_name = "#{name}="
      define_singleton_method writer_name do |value|
        set_attribute_value(name, value)
      end
    end
    private :define_attribute_methods

    def define_attribute_variable(name, type, options)
      instance_variable_set "@#{name}", Attribute.new(type, options)
    end
    private :define_attribute_variable

    def get_attribute_value(name)
      instance_variable_get("@#{name}").get
    end
    protected :get_attribute_value

    def set_attribute_value(name, value)
      instance_variable_get("@#{name}").set value
    end
    protected :set_attribute_value

    def attribute_definitions
      self.class.instance_variable_get("@attribute_definitions")
    end
    private :attribute_definitions

  end
end
