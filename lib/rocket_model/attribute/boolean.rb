module RocketModel
  class Attribute
    class Boolean < Object

      def convert
        case value
        when ::Numeric then convert_from_num
        when ::String then convert_from_str
        else
          convertion_error
        end
      end

      private

      def convert_from_str
        case value.downcase
        when *%w( 1 on  t true  y yes ) then true
        when *%w( 0 off f false n no  ) then false
        else
          convertion_error
        end
      end

      def convert_from_num
        case value.to_i
        when 1 then true
        when 0 then false
        else
          convertion_error
        end
      end
    end
  end
end
