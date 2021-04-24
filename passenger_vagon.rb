# frozen_string_literal: true

class PassengerVagon < Vagon
  def initialize
    super
    @type = 'passenger'
  end
end
