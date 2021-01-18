# frozen_string_literal: true

require 'form_attribute/version'
require 'form_attribute/errors'
require 'form_attribute/boolean'

module FormAttribute
  def self.extended(base)
    base.instance_variable_set('@attrs', {})
    base.include InstanceMethods
    base.define_method('initialize') do |**attributes|
      write_many(**attributes)
    end
  end

  def attribute(name, type, options = {})
    name = name.to_sym
    default = options[:default]

    init_attribute(name, type, default)

    matching_type_for(name, default)

    define_accessors(name)
  end

  def attributes
    @attrs.keys
  end

  def type_of(name)
    attr(name)[:type]
  end

  def default_for(name)
    attr(name)[:default]
  end

  def matching_type_for(name, value)
    return true if value.nil?

    type_of(name).each do |type|
      return true if value.is_a? type
    end
    raise TypeError, "Value for #{name.inspect} is the wrong type"
  end

  private

  def init_attribute(name, type, default)
    @attrs[name] = {
      type: [type].flatten,
      default: default
    }
  end

  def define_accessors(name)
    define_method("#{name}=") { |value| write_attribute(name, value) }
    define_method(name) { read_attribute(name) }
  end

  def attr(name)
    attribute = @attrs[name]
    return attribute if attribute

    raise UnknownAttributeName, name.inspect
  end

  module InstanceMethods
    def inspect
      attrs = attributes.map { |name| "#{name}: #{read_attribute(name).inspect}" }.join(', ')
      "#<#{self.class} #{attrs}>"
    end

    private

    def write_many(**attributes)
      attributes.each { |name, value| write_attribute(name, value) }
    end

    def write_attribute(name, value)
      matching_type_for(name, value)
      instance_variable_set("@#{name}", value)
    end

    def read_attribute(name)
      raise UnknownAttributeName, name unless attributes.include? name

      value = instance_variable_get("@#{name}")
      value || default_for(name)
    end

    def attributes
      self.class.attributes
    end

    def matching_type_for(name, value)
      self.class.matching_type_for(name, value)
    end

    def default_for(name)
      self.class.default_for(name)
    end
  end
end
