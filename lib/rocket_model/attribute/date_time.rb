require "date"

module RocketModel
  module Attribute
    class DateTime < Object

      def convert
        case value
        when ::DateTime then value
        when ::Date then value.to_datetime
        when ::Time then value.to_datetime
        when ::Numeric then convert_from_num
        when ::String then convert_from_str
        else
          convertion_error
        end

      end

      private

      def convert_from_num
        ::DateTime.strptime((value * 10**3).to_s, "%Q")
      end

      def convert_from_str
        ::DateTime.parse value
      rescue ArgumentError
        convertion_error
      end
    end
  end
end
