require "pstore"

module RocketModel
  module Store
    class File < PStore

      def self.new(path:)
        super(path)
      end

      def initialize(path)
        super

        @table = {}
        fetch_all
      end

      def all(table:)
        @table[table] || []
      end

      def create(data, table:)
        @table[table] ||= []
        data["id"] = increment_sequence(table)

        @table[table] << data
        data
      end

      def read(data, table:)
        # TODO
      end

      def update(id, data, table:)
        # TODO
      end

      def delete(data, table:)
        # TODO
      end

      def persist
        table = @table #copy for available in transaction
        transaction do
          table.each do |root, value|
            self[root] = value
          end
        end
      end

      private

      def sequence(root)
        @table["#{root}_sequence"] ||= @table[root].count
      end

      def increment_sequence(root)
        @table["#{root}_sequence"] = sequence(root) + 1
      end

      def fetch_all
        transaction(true) do
          roots.each do |root|
            @table[root] = fetch(root)
          end
        end
      end
    end
  end
end