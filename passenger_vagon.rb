# frozen_string_literal: true

class PassengerVagon < Vagon
  attr_accessor :type

  def initialize(id)
    super
    @type = 'passenger'
  end
end
