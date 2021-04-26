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
      self.counter = 0 if self.counter.nil?
      self.counter
    end
  end

  module InstanceMethods
    def register_instance
      self.class.counter ||= 0
      self.class.counter +=1
    end
  end
end
