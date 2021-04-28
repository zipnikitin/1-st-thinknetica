# frozen_string_literal: true

require_relative 'modules'

class CargoTrain < Train
  def initialize(number)
    super
    @type = 'cargo'
    validate!
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  def validate!
    raise "Number can't be nil" if checker.nil?

    true
  end
end
