module RocketModel

  module DirtyAttribute

    def set(value)
      store_changes
      super if value != get
    end

    def changed?
      @previous_value != get
    end

    def previous_value
      @previous_value
    end

    def apply!
      @previous_value = get
    end

    def restore!
      set @previous_value
      apply!
    end

    def store_changes
      @previous_value ||= get
    end
    private :store_changes

    def set_defaults
      super
      apply!
    end
    private :set_defaults
  end

  # == Rocket Model Dirty
  #
  # Provides a way to track changes in your object
  #
  # Example:
  #
  #   class Person
  #     include RocketModel::AttributeMethods
  #     include RocketModel::Dirty
  #
  #     attribute :name, :String, default: "No name"
  #   end
  #
  #   person = Person.new name: "Steave"
  #   person.changes # => {"name" => ["No name", "Steave"]}
  #
  #   person.name = "Bill"
  #   person.changes # => {"name" => ["No name", "Bill"]}
  #

  module Dirty

    def set_attribute_value(name, value) # :nodoc:
      new_value = super
      if instance_variable_get("@#{name}").changed?
        changed_attributes[name] = new_value
      end
    end

    # Returns list of changed attribute names
    def changed
      changed_attributes.keys
    end

    # Returns +true+ if some attribute changed
    def changed?
      !changed.empty?
    end

    # Returns list of changed attributes with changed values
    def changes
      changed.each_with_object({}) do |name, h|
        h[name] = [previous_value(name), public_send(name)]
      end
    end

    def changes_for_save # :nodoc:
      changed.each_with_object({}) do |name, h|
        h[name] = public_send(name)
      end
    end

    # Return previous value of given attribute
    #   person.previous_value(:name) # =>"No name"
    def previous_value(name)
      v = instance_variable_get("@#{name}")
      v.previous_value
    end

    # Clean changes
    def changes_applied
      changed.each do |name|
        instance_variable_get("@#{name}").apply!
      end
      @changed_attributes = {}
    end

    # Restore previous value and clean changes
    def restore_attributes
      changed.each do |name|
        instance_variable_get("@#{name}").restore!
      end
      @changed_attributes = {}
    end

    def changed_attributes # :nodoc:
      @changed_attributes ||= {}
    end
    private :changed_attributes

    def define_attribute_variable(name, type, options) # :nodoc:
      super.extend DirtyAttribute
    end
    private :define_attribute_variable

  end
end
