module RocketModel

  # == Rocket Model Attribute Methods
  #
  # Provides a way to add attribute methods to your model
  #
  # Example:
  #
  #   class Person
  #     include RocketModel::AttributeMethods
  #
  #     attribute :name, :String, default: "No name"
  #   end
  #
  #   person = Person.new
  #   person.name # =>"No name"
  #
  #   person.name = "Bill"
  #   person.name # =>"Bill"
  #
  #   # Allow mass-assigment
  #   person2 = Person.new name: "Steave"
  #   person2.name # =>"Steave"
  #

  module AttributeMethods
    TYPES = [:Date, :DateTime, :Time, :Integer, :Float, :String, :Symbol, :Boolean]

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def attribute(name, type = nil, options = {})
        @attribute_definitions ||= {}
        validate_name(name)
        validate_type(type) if type
        @attribute_definitions[name.to_s] = [type, options]
        self
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

    def attributes
      attribute_definitions.keys.each_with_object({}) do |name, h|
        h[name] = public_send(name)
      end
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
      attribute_definitions.each do |name, args|
        define_attribute_methods(name, *args)
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
