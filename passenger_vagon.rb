# frozen_string_literal: true

class PassengerVagon < Vagon
  attr_accessor :vagon_type

  def initialize(id)
    super
    @vagon_type = 'passenger_vagon'
  end
end
