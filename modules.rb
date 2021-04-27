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
      self.counter ||= 0
      self.counter
    end
  end

  module InstanceMethods
    def register_instance
      self.class.counter ||= 0
      self.class.counter +=1
    end

    def valid?
      validate!
      rescue
      false
    end

    def validate!
      raise "Can't be nil" if self.class.digit.nil?
      true
    end


  end

end
