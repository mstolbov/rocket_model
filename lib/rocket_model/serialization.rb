module RocketModel
  module Serialization
    autoload :JSON, "rocket_model/serialization/json"
    autoload :YAML, "rocket_model/serialization/yaml"

    def self.included(base)
      base.include JSON
      base.include YAML
    end

    # == Rocket \Model \Serialization
    #
    # Provides a basic serialization to a serializable_hash for your objects.
    # An +attributes+ hash must be defined.
    #
    # A minimal implementation could be:
    #
    #   class Person
    #     include RocketModel::Serialization
    #
    #     attr_accessor :name, :role
    #
    #     def attributes
    #       {name: name, role: role}
    #     end
    #   end
    #
    #   person = Person.new
    #   person.serializable_hash   # => {:name => nil, :role => nil}
    #   person.name = "Bob"
    #   person.serializable_hash   # => {:name => "Bob", :role => nil}
    #
    #
    # Valid options are <tt>:only</tt>, <tt>:except</tt>, <tt>:include</tt>.
    # Examples:
    #
    #   person.serializable_hash(only: :name)   # => {:name => "Bob"}
    #   person.serializable_hash(except: :name) # => {:role => nil}
    #

    def serializable_hash(options = {})
      return unless respond_to?(:attributes)

      attribute_names = attributes.keys
      if options[:only]
        attribute_names &= Array(options[:only]).map(&:to_s)
      elsif options[:except]
        attribute_names -= Array(options[:except]).map(&:to_s)
      end

      attribute_names.each_with_object({}) { |n, h| h[n] = public_send(n) }
    end

  end
end
