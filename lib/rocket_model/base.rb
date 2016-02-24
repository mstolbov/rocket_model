module RocketModel
  # == Rocket Model Base
  #
  # Base class for RocketModel model.
  # Contains the database configuration. Default is <tt>Store::File</tt> with {path: "database.pstore"}
  #
  # Example:
  #   # Set global store
  #   RocketModel::Base.configure do |c|
  #     c.store = {store: "postgres", database: "my_database", username: "postgres", password: "")
  #   end
  #
  #   class Person < RocketModel::Base
  #     attribute :name
  #   end
  #
  #   Person.store.class # => RocketModel::Store::File
  #
  #
  class Base
    include AttributeMethods
    include Dirty
    include Core
    include RepositoryMethods
    include Serialization

    def self.config
      @config ||= Configuration.new
    end

    def self.configure
      yield config if block_given?
    end

  end
end
