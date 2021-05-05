# frozen_string_literal: true

require_relative 'modules'

class Demo
  include Accessor
  include Validation
  attr_accessor :collect_values

  attr_accessor_with_history :d1, :d2, :d3
  strong_attr_accessor :d1, Integer
  validate :d2, :presence
  validate :d3, :type, Integer
end
