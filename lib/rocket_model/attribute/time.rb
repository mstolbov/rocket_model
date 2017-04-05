require "date"

module RocketModel
  class Attribute
    class Time < Object

      def convert
        case value
        when ::String then convert_from_str
        when ::Time then value
        when ::Date then value.to_time
        when ::DateTime then value.to_time
        else
          convertion_error
        end
      end

      private

      def convert_from_str
        ::Time.parse value
      rescue ArgumentError
        convertion_error
      end
    end
  end
end
