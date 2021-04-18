# frozen_string_literal: true

class CargoVagon < Vagon
  attr_accessor :vagon_type

  def initialize(id)
    super
    @vagon_type = 'cargo_vagon'
  end
end
