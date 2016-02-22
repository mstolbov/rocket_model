module RocketModel
  class Repository
    attr_reader :table_name, :store

    def initialize(model)
      @table_name = model.table_name
      @store = model.store
    end

    def all(model)
      store.all(table: table_name).map {|data| model.new data}
    end

    def find(model, id)
      key = model.primary_key
      condition = {"#{key}" => id}
      data = store.read(condition, table: table_name).first
      fail RecordNotFound.new(condition, table_name) unless data

      model.new data
    end

    def where(model, condition)
      store.read(condition, table: table_name).map {|data| model.new data}
    end

    def create(model)
      data = model.attributes
      record = store.create(data, table: table_name)
      model.attributes = record
    end

    def update(model)
      id, data = model.primary_key_value, model.changes
      store.update(id, data, table: table_name)
    end

    def detele(model)
      id = model.primary_key_value
      store.delete(id, table: table_name)
    end

    def persist
      store.persist
    end
  end

  module RepositoryMethods

    def self.included(base)
      base.extend ClassMethods
      base.class_eval do
        attribute :id, :Integer#, read_only: true
      end
    end

    module ClassMethods
      def repository
        @repository ||= Repository.new(self)
      end

      def repository=(repository_klass)
        @repository = repository_klass.new(self)
      end

      def table_name
        @table_name ||= self.to_s.tableize
      end

      def table_name=(name)
        @table_name = name
      end

      def primary_key=(key)
        @primary_key = key
      end

      def primary_key
        @primary_key ||= :id
      end

      def create(attrs = {})
        record = new(attrs)
        record.save
        record
      end

      def find(id)
        repository.find(self, id)
      end

      def where(condition)
        repository.where(self, condition.stringify_keys)
      end

      def all
        repository.all(self)
      end
    end

    def primary_key
      self.class.primary_key
    end

    def primary_key_value
      public_send(primary_key)
    end

    def save
      if new_record?
        repository.create(self)
      elsif !persisted?
        repository.update(self)
      end

      changes_applied
      repository.persist
    end

    def delete
      repository.delete(self)
      repository.persist
    end

    def new_record?
      !primary_key_value
    end

    def persisted?
      !new_record? && !changed?
    end

    def repository
      self.class.repository
    end
    private :repository
  end
end
