module RocketModel
  class Attribute
    autoload :Object,   "rocket_model/attribute/object"
    autoload :Numeric,  "rocket_model/attribute/numeric"
    autoload :Date,     "rocket_model/attribute/date"
    autoload :DateTime, "rocket_model/attribute/date_time"
    autoload :Time,     "rocket_model/attribute/time"
    autoload :Integer,  "rocket_model/attribute/integer"
    autoload :Float,    "rocket_model/attribute/float"
    autoload :String,   "rocket_model/attribute/string"
    autoload :Symbol,   "rocket_model/attribute/symbol"
    autoload :Boolean,  "rocket_model/attribute/boolean"

    def initialize(type, options)
      @type = type
      @default = options.fetch(:default, nil)

      set_default
    end

    def set(new_value)
      @value = convert(new_value)
    end

    def get
      @value
    end

    private

    def convert(value)
      return value unless @type
      type_klass = Object.const_get("RocketModel::Attribute::#{@type}")
      type_klass.new(value).convert
    end

    def set_default
      set(@default) if @default
    end

  end
end
