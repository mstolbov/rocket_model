require "date"

module RocketModel
  module Attribute
    class Date < Object

      def convert
        case value
        when ::Date then value
        when ::DateTime then value.to_date
        when ::Time then value.to_date
        when ::String then convert_from_str
        else
          convertion_error
        end
      end

      private

      def convert_from_str
        ::Date.parse value
      rescue ArgumentError
        convertion_error
      end
    end
  end
end
