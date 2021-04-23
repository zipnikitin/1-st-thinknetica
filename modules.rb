# frozen_string_literal: true

module AdjustBrand
  def adjust(name)
    self.brand = name
  end

  def show_brand
    brand
  end

  protected

  attr_accessor :brand
end

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      all.count
    end
  end

  module InstanceMethods
    def register_instance
      self.class.instances
    end
  end
end
