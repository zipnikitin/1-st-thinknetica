# frozen_string_literal: true

class CargoVagon < Vagon
  attr_accessor :type

  def initialize(id)
    super
    @type = 'cargo'
  end
end
