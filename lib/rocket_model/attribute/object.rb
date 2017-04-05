module RocketModel
  class Attribute
    class Object < Attribute
      attr_reader :value

      def initialize(value)
        @value = value
      end

      def convert
        fail NotImplementedError
      end

      private

      def convertion_error
        fail TypeError, "can't convert #{value.class} into #{self.class}"
      end
    end
  end
end
