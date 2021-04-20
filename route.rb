# frozen_string_literal: true

class Route
  attr_reader :first, :last, :route_stations

  def initialize(first, last)
    @route_stations = [first, last]
  end

  def plus_station(station)
    @route_stations.insert(route_stations.lenght - 1, station)
  end

  def delete(station)
    @route_stations.delete(station)
  end
end
