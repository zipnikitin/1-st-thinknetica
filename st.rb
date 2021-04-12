class Station
  attr_accessor :trains
  attr_reader :trains, :name, :f_trains, :p_trains
  def initialize(name)
    @name = name
    @trains = 0
    @f_trains = 0
    @p_trains = 0
    @trains_numbers = []
  end

  def there(name)
    @trains_numbers.delete(name)
  end

  def add_train(new_number, type)
    (@trains_numbers.append(new_number);  @trains += 1) if @train.speed != 0
    (@f_trains += 1) if @type == 'f' 
    (@p_trains += 1) if @type == 'p' 
  end

  def show_trains
  	@trains
  	@f_trains
  	@p_trains
    @trains_numbers.each { |number| puts trains_numbers.number }
  end
end

class Route
  attr_reader :first, :last, :station_names
  def initialize(first, last)
  	@first = first
  	@last = last
    @station_names = [first, last]
  end

  def plus_station(name)
  	@station_names.insert(station_names.lenght-1, name)
  end 

  def del_first(name)
  	@station_names.delete(name)
  end 

  def show_route
    @station_names.each { |name| puts station_names.name }
  end
end

class Train
  attr_reader :speed, :vagons, :number, :type

  def initialize(number, type, vagons)
  	@type = type
    @number = number
    @speed = 0
    @current_station
    @vagons = vagons
    @tr_route = [] 
  end

  def fast(up)
    @speed += up
  end

  def stop
    @speed = 0
  end

  def longer
    (@vagons += 1) if @speed == 0 
  end

  def shorter
    (@vagons -= 1) if @speed == 0 
  end

  def add_route(tr_route)
    @tr_route = tr_route
    @tr_route.first.add_train(self)
  end

  def next_station
  	unless @current_station==@tr_route.station_names
  		@current_station += 1
  	end
  	tr_route.station_names[current_station].add_train
  end

  def prev_station
  	unless @current_station==@tr_route.station_names
  		@current_station -= 0
  	end
  	tr_route.station_names[current_station].add_train
  end

  def now
  	return @tr_route.station_names[current_station]
  end
end
