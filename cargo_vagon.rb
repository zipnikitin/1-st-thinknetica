# frozen_string_literal: true

class CargoVagon < Vagon
  def initialize
    super
    @type = 'cargo'
  end
end
