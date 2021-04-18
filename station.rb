# frozen_string_literal: true

class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    return unless @train.speed.zero?

    @trains.append(train)
    train.stop
  end

  def trains_by(type)
    trains.filter { |train| train.type == type }
  end

  def count_trains_by(type)
    trains.count { |train| train.type == type }
  end

  def send_train(train)
    @trains.delete_train(train)
  end
end
