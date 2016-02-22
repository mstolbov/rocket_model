module RocketModel
  class Config
    class << self
      def store=(store)
        @store = store
      end

      def store
        @store
      end
    end

    def initialize(obj)
      @obj = obj
    end

    def configure
      @obj.store = self.class.store if self.class.store
    end

  end
end
