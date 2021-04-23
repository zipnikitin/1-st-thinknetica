# frozen_string_literal: true

require_relative 'modules'

class Vagon
  include AdjustBrand
  attr_accessor :type

  def initialize
    @type = type
  end
end
