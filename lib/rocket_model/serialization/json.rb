require 'json'

module RocketModel
  module Serialization
    # Returns a string representing the model in json. Some configuration can be
    # passed through +options+.
    #
    #   class Person
    #     include RocketModel::Serialization::JSON
    #
    #     attr_accessor :name, :role
    #
    #     def attributes
    #       {name: name, role: role}
    #     end
    #   end
    #
    #   person = Person.new
    #   person.to_json   # => "{\"name\":null,\"kind\":null}"
    #

    module JSON

      def to_json(options = {})
        serializable_hash(options).to_json
      end
    end
  end
end
