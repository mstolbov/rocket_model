require "rocket_model/version"

module RocketModel
  autoload :AttributeMethods, "rocket_model/attribute_methods"
  autoload :Attribute, "rocket_model/attribute"
  autoload :UnknownAttributeError, "rocket_model/errors"

  autoload :Dirty, "rocket_model/dirty"
  autoload :DirtyAttribute, "rocket_model/dirty"

  autoload :Serialization, "rocket_model/serialization"

  def self.included(base)
    base.include AttributeMethods
    base.include Dirty
    base.include Serialization
  end
end
