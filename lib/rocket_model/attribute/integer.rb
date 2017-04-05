module RocketModel
  class Attribute
    class Integer < Numeric

      def convert
        case value
        when ::Numeric then value.to_i
        when ::String then value.to_i
        when ::Time then value.to_i
        when ::Object then value.respond_to?(:to_int) ? value.to_int : convertion_error
        else
          convertion_error
        end
      end
    end
  end
end
