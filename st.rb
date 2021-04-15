class Station
  attr_reader :trains_here, :name

  def initialize(name)
    @name = name
    @count_trains = 0
    @trains = []
  end

  def add_train(train)
    return unless @train.speed == 0
    @trains.append(train)
    train.stop
  end

  def trains_by(type)
    trains.filter { |train| train.type == type }
  end

  def count_trains_by(type)
    trains_by(type)
    trains.length
  end

  def send_train(train)
    @trains.delete_train(train)
  end
end

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

class Train
  attr_reader :speed, :vagons, :number, :type, :route

  def initialize(number, type, vagons)
    @number = number
    @type = type
    @speed = 0
    @vagons = vagons
  end

  def fast(up)
    @speed += up
  end

  def stop
    @speed = 0
  end

  def longer
    @vagons += 1 if @speed == 0
  end

  def shorter
    @vagons -= 1 if @speed == 0 & @amount_of_vagons > 0
  end

  def add_route(route)
    @route = route
    @current_station_index = 0
    current_station.add_train(self)
  end

  def move_forward
    if @current_station_index != @route.last
    @current_station_index += 1 
    route.route_stations[@current_station_index].add_train(self)
    current_station.send_train(self)
    next_station.add_train(self)
    end
  end

  def move_back
  	if @current_station_index != @route.first
    @current_station_index -= 1 
    route.route_stations[@current_station_index].add_train(self)
    current_station.send_train(self)
    previous_station.add_train(self)
    end
  end

  def previous_station
    @route.route_stations[@current_station_index - 1] unless @current_station_index == 0
  end

  def next_station
    @route.route_stations[@current_station_index + 1] unless @current_station_index == @route.route_stations.length
  end

  def current_station
    @route.route_stations[@current_station_index]
  end
end
