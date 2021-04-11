class Station
  attr_accessor :trains

  def initialize(name, trains_numbers = [])
    @name = name
    @trains = 0
    @f_trains = 0
    @p_trains = 0
    @trains_numbers = []
  end

  def there(name)
    @trains_numbers.remove(name)
  end

  def add_train(number, type)
    (@trains_numbers << number; @trains += 1) if @train.speed != 0
    (@f_trains += 1) if @type == 'f' 
    (@p_trains += 1) if @type == 'p' 
  end

  def show_trains
  	return @trains
  	return @f_trains
  	return @p_trains
    return @trains_numbers.each { |number| puts number }
  end
end

class Route
  def initialize(first, last)
  	@station_names.unshift(first)
  	@station_names.unpop(last)
    @station_names = []
  end

  def plus_station(name)
  	@station_names.insert(-1, name)
  end 

  def del_first(name)
  	@station_names.remove(name)
  end 

  def show_route
    @station_names.each { |name| puts name }
  end
end

class Train
  attr_accessor :speed, :vagons

  def initialize(number, type)
  	@type = type
    @number = number
    @speed = 0
    @vagons = 0
    @route = []
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

  def add_route
    @rouete = station_names
  end

  def show_route
    @train_route.each { |name| puts name }
  end
end
