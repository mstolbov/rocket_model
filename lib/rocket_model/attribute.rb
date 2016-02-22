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
      @read_only = options.fetch(:read_only, false)

      set_defaults
    end

    def set(value)
      return if @read_only

      @value = convert(value)
    end

    def get
      @value
    end

    def force_set(value) # :nodoc:
      # Used for update readonly attribute
      @value = convert(value)
    end

    private

    def convert(value)
      return value unless @type
      type_klass = "RocketModel::Attribute::#{@type}".constantize
      type_klass.new(value).convert
    end

    def set_defaults
      set(@default) if @default
    end

  end
end
