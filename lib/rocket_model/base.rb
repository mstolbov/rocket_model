module RocketModel
  module Base

    def self.included(base)
      base.include Attribute
    end
  end
end
