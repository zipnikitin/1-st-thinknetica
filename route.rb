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
    @checker = first
    validate!
    @checker = last
    validate!
  end

  def plus_station(station)
    @route_stations.insert(route_stations.lenght - 1, station)
    @checker = station
    validate!
  end

  def delete(station)
    @route_stations.delete(station)
    @checker = station
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
