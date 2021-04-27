# frozen_string_literal: true
require_relative 'modules'

class CargoTrain < Train
  def initialize(number)
    super
    @type = 'cargo'
    @digit = number
    validate!
  end
end
