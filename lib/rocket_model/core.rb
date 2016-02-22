module RocketModel
  # == Rocket \Model \Core
  #
  # Contains the database configuration. Default is <tt>Store::File</tt> with {path: "database.pstore"}
  #
  # Example:
  #   # Set global store
  #   RocketModel.config do |c|
  #     c.store = {store: "postgres", database: "my_database", username: "postgres", password: "")
  #   end
  #
  #   class Person
  #     include RocketModel
  #     attribute :name
  #   end
  #
  #   person = Person.new name: "Bill G."
  #   person.save
  #   person.persisted? # => true
  #
  #
  #   # Change store for model
  #   class User < Person
  #     store = {store: "file", path: "database.pstore")
  #   end
  #
  module Core

    def self.included(base)
      base.extend ClassMethods
      base.class_eval do
        configure do |c|
          Config.new(c).configure
        end
      end
    end

    module ClassMethods

      def configure
        yield self
      end

      def store=(store)
        @store = store
      end

      def store
        return @connection if @connection

        @store ||= {store: "file", path: "database.pstore"}
        store = @store.fetch(:store)
        options = @store.select {|k,v| k != :store}
        @connection = "rocket_model/store/#{store}".camelize.constantize.new(options)
      end

      def inspect
        attr_list = @attribute_definitions.map do |name, type, _|
          "#{name}:#{type}"
        end.join(", ")
        "#{super}(#{attr_list})"
      end
    end

    def initialize(attrs = {})
      define_attributes
      self.attributes = attrs
    end

    def inspect
      inspect_attributes = attributes.map { |k, v| "#{k}: #{v.inspect}" }.join(", ")
      "#<#{self.class} #{inspect_attributes}>"
    end


  end
end
