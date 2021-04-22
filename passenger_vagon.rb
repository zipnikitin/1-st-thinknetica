# frozen_string_literal: true

class PassengerVagon < Vagon

  def initialize(id)
    super
    @type = 'passenger'
  end
end
