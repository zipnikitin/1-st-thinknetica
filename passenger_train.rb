# frozen_string_literal: true

class PassengerTrain < Train
  def initialize(number)
    super
    @type = 'passenger'
    @digit = number
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
