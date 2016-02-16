require "rocket_model/version"

module RocketModel
  autoload :AttributeMethods, "rocket_model/attribute_methods"
  autoload :Attribute, "rocket_model/attribute"
  autoload :UnknownAttributeError, "rocket_model/errors"

  def self.included(base)
    base.include AttributeMethods
  end
end
