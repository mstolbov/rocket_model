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

  module Dirty

    def set_attribute_value(name, value)
      new_value = super
      if instance_variable_get("@#{name}").changed?
        changed_attributes[name] = new_value
      end
    end

    def changed
      changed_attributes.keys
    end

    def changed?
      !changed.empty?
    end

    def changes
      h = {}
      changed.each do |name|
        h[name] = [previous_value(name), public_send(name)]
      end
      h
    end

    def previous_value(name)
      v = instance_variable_get("@#{name}")
      v.previous_value
    end

    def changes_applied
      changed.each do |name|
        instance_variable_get("@#{name}").apply!
      end
      @changed_attributes = {}
    end

    def restore_attributes
      changed.each do |name|
        instance_variable_get("@#{name}").restore!
      end
      @changed_attributes = {}
    end

    def changed_attributes
      @changed_attributes ||= {}
    end
    private :changed_attributes

    def define_attribute_variable(name, type, options)
      super.extend DirtyAttribute
    end
    private :define_attribute_variable

  end
end
