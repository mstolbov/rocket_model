module RocketModel
  # == Rocket \Model \Core
  #
  # Contains the store configuration. Default is <tt>Store::File</tt> with {path: "database.pstore"}
  #
  # Example:
  #
  #   class Person < RocketModel::Base
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
    end

    module ClassMethods

      def store=(store)
        @store = store
      end

      def store
        return @connection if @connection

        @store ||= self.superclass.config.store
        store = @store.fetch(:store)
        options = @store.select {|k,v| k != :store}
        @connection = "rocket_model/store/#{store}".camelize.constantize.new(options)
      end

      def inspect
        return super unless @attribute_definitions
        attr_list = @attribute_definitions.map do |name, args|
          "#{name}:#{args.first}"
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
