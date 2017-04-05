module RocketModel
  class Configuration
    attr_accessor :store

    def initialize
      @store = {store: "file", path: "database.pstore"}
    end

  end
end
