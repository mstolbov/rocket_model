module RocketModel
  class Attribute
    class String < Object

      def convert
        case value
        when ::FalseClass, ::TrueClass then value.to_s
        when ::Numeric then value.to_s
        when ::Symbol then value.to_s
        when ::Date, ::DateTime, ::Time then value.to_s
        when ::Object then value.respond_to?(:to_str) ? value.to_str : convertion_error
        else
          convertion_error
        end
      end
    end
  end
end
