module RocketModel
  module Attribute
    class Symbol < Object

      def convert
        case value
        when ::String then value.to_sym
        else
          convertion_error
        end
      end
    end
  end
end
