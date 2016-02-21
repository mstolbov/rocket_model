require 'yaml'

module RocketModel
  module Serialization
    module YAML

      # Returns a string representing the model in yaml. Some configuration can be
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
      #   person.to_yaml   # => "---\nname: \role: \n"
      #

      def to_yaml(options = {})
        serializable_hash(options).to_yaml
      end
    end
  end
end
