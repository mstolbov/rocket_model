module RocketModel
  module Attribute
    class Float < Numeric

      def convert
        case value
        when ::Numeric then value.to_f
        when ::String then value.to_f
        else
          convertion_error
        end
      end
    end
  end
end
