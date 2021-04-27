# frozen_string_literal: true

require_relative 'modules'

class Route
  include InstanceCounter
  attr_reader :first, :last, :route_stations

  @@instances = []

  def self.all
    @@instances
  end

  def initialize(first, last)
    @route_stations = [first, last]
    @@instances.append(self)
    @digit = first
    validate!
  end

  def plus_station(station)
    @route_stations.insert(route_stations.lenght - 1, station)
    @digit = station
    validate!
  end

  def delete(station)
    @route_stations.delete(station)
    @digit = station
    validate!
  end
end
