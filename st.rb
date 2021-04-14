class Station
  attr_reader :trains_here, :name

  def initialize(name)
    @name = name
    @count_trains = 0
    @trains = []
  end

  def trains_by(type)
    trains.filter { |train| train.type == type }
  end

  def there(train)
    @trains.delete_train(train)
  end

  def count_trains_by(type)
    trains_by(type)
    trains.length
  end

  def add_train(train)
    (@trains.append(train); train.stop;  @trains += 1) if @train.speed != 0
  end
end

class Route
  attr_reader :first, :last, :route_stations

  def initialize(first, last)
    @route_stations = [first, last]
  end

  def plus_station(station)
    @route_stations.insert(route_stations.lenght-1, station)
  end 

  def delete(station)
    @route_stations.delete(station)
  end
end

class Train
  attr_reader :speed, :vagons, :number, :type, :route

  def initialize(number, type, vagons)
    @type = type
    @number = number
    @speed = 0
    @current_station
    @vagons = vagons
    @route 
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
    first.add_train(self)
  end

  def move_forward
    move_forward.add_train(self)
    current_station.there(self)
    @current_station_index += 1 if @current_station_index!=@route.last
  end

  def move_back
    move_back.add_train(self)
    current_station.there(self)
    @current_station_index -= 1 if @current_station_index!=@route.first
  end
  
  def previous_station
    unless @current_station_index == 0
      @route.route_stations[@current_station_index - 1]
    end
  end

  def next_station
    unless @current_station_index == @route.route_stations.length
      @route.route_stations[@current_station_index + 1]
    end
  end

  def current_station
    @route.route_stations[@current_station_index]
  end
end
