# frozen_string_literal: true

class PassengerTrain < Train
  def initialize(number)
    super
    @type = 'passenger_train'
  end
end
