module RocketModel
  class UnknownAttributeError < NoMethodError
    attr_reader :model, :attribute

    def initialize(model, attribute)
      @model = model
      @attribute = attribute
      super("unknown attribute '#{attribute}' for #{@model.class}.")
    end
  end
end
