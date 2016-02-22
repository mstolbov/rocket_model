module RocketModel
  class UnknownAttributeError < NoMethodError
    attr_reader :model, :attribute

    def initialize(model, attribute)
      super("unknown attribute '#{attribute}' for #{model.class}.")
    end
  end

  class RecordNotFound < RuntimeError

    def initialize(condition, table)
      super("can't find '#{condition}' in table #{table}.")
    end
  end
end
