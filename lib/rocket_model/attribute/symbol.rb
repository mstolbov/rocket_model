module RocketModel
  class Attribute
    class Symbol < Object

      def convert
        case value
        when ::String then value.to_sym
        when ::Symbol then value
        else
          convertion_error
        end
      end
    end
  end
end
