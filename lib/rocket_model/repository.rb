module RocketModel
  # == Rocket Model Repository
  # Provides a way to access to store and provide model
  #
  # Example:
  #
  #   class Person
  #     include RocketModel
  #
  #     attribute :name
  #   end
  #
  #   Person.create(name: "Bill")
  #   Person.all # => [#<Person id: 1, name: "Bill">]
  #
  class Repository
    attr_reader :table_name, :store

    def initialize(model)
      @table_name = model.table_name
      @store = model.store
    end

    # Returns array of all records in store
    def all(model)
      store.all(table: table_name).map {|data| model.new data}
    end

    # Returns found record or +raise RecordNotFound+ exception
    def find(model, id)
      key = model.primary_key
      condition = {"#{key}" => id}
      data = store.read(condition, table: table_name).first
      fail RecordNotFound.new(condition, table_name) unless data

      model.new data
    end

    # Returns array of found records by condition in store
    def where(model, condition)
      store.read(condition, table: table_name).map {|data| model.new data}
    end

    # Create record in store
    def create(model)
      data = model.attributes
      record = store.create(data, table: table_name)
      model.attributes = record
    end

    # Update record data in store
    def update(model)
      id, data = model.primary_key_value, model.changes_for_save
      store.update(id, data, table: table_name)
    end

    # Delete record in store
    def delete(model)
      id = model.primary_key_value
      store.delete(id, table: table_name)
    end

    # Persist store changes
    def persist
      store.persist
    end
  end

  # == Rocket Model Repository
  # Provides a way to persist the model.
  #
  # Example:
  #
  #   class Person
  #     include RocketModel
  #
  #     attribute :name
  #   end
  #
  #   person = Person.new(name: "Bill")
  #   person.save
  #
  #   Person.all # => [#<Person id: 1, name: "Bill">]
  #
  module RepositoryMethods

    def self.included(base)
      base.extend ClassMethods
      base.class_eval do
        attribute :id, :Integer#, read_only: true
      end
    end

    module ClassMethods
      # Returns repository instanse
      def repository
        @repository ||= Repository.new(self)
      end

      # Sets custom repository
      #
      #   class Person
      #     included RocketModel
      #     repository = MyRepository
      #
      #     attribute :name
      #   end
      def repository=(repository_klass)
        @repository = repository_klass.new(self)
      end

      # Returns table name
      def table_name
        @table_name ||= self.to_s.tableize
      end

      # Sets name to table
      #
      #   class Person
      #     included RocketModel
      #     table_name = "users"
      #
      #     attribute :name
      #   end
      def table_name=(name)
        @table_name = name
      end

      # Sets table primary key
      #
      #   class Person
      #     included RocketModel
      #     primary_key = :uuid
      #
      #     attribute :uuid, :Integer
      #     attribute :name
      #   end
      def primary_key=(key)
        @primary_key = key
      end

      # Returns table primary key. Default +:id+
      def primary_key
        @primary_key ||= :id
      end

      # Creates record
      #
      #   class Person
      #     included RocketModel
      #
      #     attribute :name
      #   end
      #
      #   Person.create name: "Bill"
      #
      def create(attrs = {})
        record = new(attrs)
        record.save
        record
      end

      # Find record by primary_key (+:id+)
      #
      #   class Person
      #     included RocketModel
      #
      #     attribute :name
      #   end
      #
      #   Person.find(1)
      #
      def find(id)
        repository.find(self, id)
      end

      # Find record by condition
      #
      #   class Person
      #     included RocketModel
      #
      #     attribute :name
      #   end
      #
      #   Person.where(name: "Bill")
      #
      def where(condition)
        repository.where(self, condition.stringify_keys)
      end

      # Returns all record for model
      def all
        repository.all(self)
      end
    end

    def primary_key # :nodoc:
      self.class.primary_key
    end

    def primary_key_value # :nodoc:
      public_send(primary_key)
    end

    # Updates record data
    def update(attrs)
      self.attributes = attrs
      save
    end

    # Persist record data
    def save
      if new_record?
        repository.create(self)
      elsif !persisted?
        repository.update(self)
      end

      changes_applied
      repository.persist
    end

    # Delete record
    def delete
      repository.delete(self)
      repository.persist
    end

    # Returns +true+ if record hasn't primary key value
    def new_record?
      !primary_key_value
    end

    # Returns +true+ if record persisted
    def persisted?
      !new_record? && !changed?
    end

    def repository # :nodoc:
      self.class.repository
    end
    private :repository
  end
end
