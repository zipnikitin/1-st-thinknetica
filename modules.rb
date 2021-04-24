# frozen_string_literal: true

module AdjustBrand
  attr_accessor :brand
end

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
  	attr_reader :counter
    def instances
      @counter = -1 if @counter.nil?
      @counter += 1
    end
  end

  module InstanceMethods
    def register_instance
      self.class.instances
    end
  end
end
