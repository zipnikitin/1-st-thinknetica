# frozen_string_literal: true

require_relative 'modules'

class Station
  include InstanceCounter
  attr_reader :trains, :name

  @@instances = []

  def self.all
    @@instances
  end

  def initialize(name)
    @name = name
    @trains = []
    @@instances.append(self)
    @checker = name
    validate!
  end

  def add_train(train)
    return unless @train.speed.zero?

    @trains.append(train)
    train.stop
    @checker = type
    validate!
  end

  def trains_by(type)
    trains.filter { |train| train.type == type }
    @checker = type
    validate!
  end

  def count_trains_by(type)
    trains.count { |train| train.type == type }
    @checker = type
    validate!
  end

  def send_train(train)
    @trains.delete_train(train)
    @checker = train
    validate!
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  def validate!
    raise "Type can't be nil" if checker.nil?

    true
  end
end
