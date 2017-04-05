require "active_support/core_ext/string/inflections"
require "active_support/core_ext/hash/keys"
require "rocket_model/version"

module RocketModel
  autoload :UnknownAttributeError, "rocket_model/errors"
  autoload :RecordNotFound, "rocket_model/errors"

  autoload :AttributeMethods, "rocket_model/attribute_methods"
  autoload :Attribute, "rocket_model/attribute"

  autoload :Dirty, "rocket_model/dirty"
  autoload :DirtyAttribute, "rocket_model/dirty"

  autoload :Serialization, "rocket_model/serialization"

  autoload :Core, "rocket_model/core"

  autoload :Repository, "rocket_model/repository"
  autoload :RepositoryMethods, "rocket_model/repository"
  autoload :Store, "rocket_model/store"

  autoload :Configuration, "rocket_model/configuration"

  autoload :Base, "rocket_model/base"
end
