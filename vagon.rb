# frozen_string_literal: true

require_relative 'modules'

class Vagon
  include InstanceCounter
  include AdjustBrand
  attr_accessor :type

  def initialize
    @type = type
    @checker = type
    validate!
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  def validate!
    raise "Type can't be nil" if checker.nil?

    true
  end
end
