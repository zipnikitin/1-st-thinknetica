# frozen_string_literal: true

require_relative 'modules'

class Vagon
  include InstanceCounter
  include AdjustBrand
  attr_accessor :type

  def initialize
    @type = type
    @digit = type 
    validate!
  end
end
