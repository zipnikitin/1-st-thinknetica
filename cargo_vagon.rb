# frozen_string_literal: true
require_relative 'modules'

class CargoVagon < Vagon
  def initialize
    super
    @type = 'cargo'
    validate!
  end
end
