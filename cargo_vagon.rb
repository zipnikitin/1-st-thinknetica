# frozen_string_literal: true

class CargoVagon < Vagon

  def initialize(id)
    super
    @type = 'cargo'
  end
end
