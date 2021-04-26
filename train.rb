# frozen_string_literal: true

require_relative 'modules'

class Train
  include InstanceCounter
  include AdjustBrand
  attr_reader :speed, :vagons, :number, :type, :route

  @@instances = []

  def self.all
    @@instances
  end

  def self.find(number)
    @@instances.find { |train| train.number == number.to_s }
  end

  def initialize(number)
    @number = number
    @type = 0
    @speed = 0
    @vagons = []
    @@instances.append(self)
    register_instance
  end

  def fast(speedup)
    @speed += speedup
  end

  def stop
    @speed = 0
  end

  def longer(vagon)
    @vagons.append(vagon) if @speed.zero? && vagon.type == @type
  end

  def shorter
    @vagons.pop if @speed.zero?
  end

  def move_forward
    return unless next_station

    next_station.add_train(self)
    current_station.send_train(self)
    @current_station_index += 1
  end

  def move_back
    return unless previous_station

    previous_station.add_train(self)
    current_station.send_train(self)
    @current_station_index -= 1
  end

  def add_route(route)
    @route = route
    @current_station_index = 0
    current_station.add_train(self)
  end

  private

  def previous_station
    @route.route_stations[@current_station_index - 1] unless @current_station_index.zero?
  end

  def next_station
    @route.route_stations[@current_station_index + 1] unless @current_station_index == @route.route_stations.length
  end

  def current_station
    @route.route_stations[@current_station_index]
  end
end

