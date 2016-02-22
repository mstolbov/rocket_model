module RocketModel
  module Core

    # RocketModel::Core
    #
    # Contains the database configuration. Default is <tt>Store::File</tt> with {path: "database.pstore"}
    #
    # Example:
    #   RocketModel.config do |c|
    #     c.store = Store::Postgres, database: "my_database", username: "postgres", password: ""
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

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

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
