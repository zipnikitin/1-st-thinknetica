class Station
  attr_reader :trains_here, :name

  def initialize(name)
    @name = name
    @trains = 0
    @trains_here = []
  end

  def trains_by(type)
    trains_here = []
    @trains.each do |train|
      if train.type == type
        trains_here.append(train.number)
      end
  end

  def there(name)
    @trains_here.delete(name)
  end

  def count_trains_by(type)
  	trains_here = []
    @trains.each do |train|
      if train.type == type
        trains_here.append(train.number)
      end
    trains_here.length
  end

  def add_train(new_number, type)
    (@trains.append(new_number); new_number.stop)  @trains += 1 if @train.speed != 0
  end
end

class Route
  attr_reader :first, :last, :route_stations

  def initialize(first, last)
    @route_stations = [first, last]
  end

  def plus_station(name)
  	@route_stations.insert(route_stations.lenght-1, name)
  end 

  def del_first(name)
  	@route_stations.delete(name)
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
    @station_now = 0
    first.add_train(self)
  end

  def next_station
  	next_station.add_train(self)
    current_station.there(self)
    @station_now += 1
  end

  def previous_station
  	previous_station.add_train(self)
    current_station.there(self)
    @station_now -= 1 
  end
  
  def show_previous
    unless @station_now == 0
      @own_route.list_of_stations[@station_now - 1]
    end
  end

  def show_next
    unless @station_now == @route.route_stations.length
      @route.route_stations[@station_now + 1]
    end
  end

  def now
    @route.roue_stations[@station_now]
  end
end
