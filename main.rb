# frozen_string_literal: true

require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'vagon'
require_relative 'cargo_vagon'
require_relative 'passenger_vagon'
require_relative 'modules'

class Main
  def initialize
    new_stations = []
    new_trains = []
    new_routes = []
  end

  def start
    x = 'none'
    while x != '0'
      puts 'Добро пожаловать в Портал КривЖД!
      1. Добавить новый поезд
      2. Добавить новую станцию
      3. Добавить новый маршрут
      4. Добавить станцию в маршрут
      5. Удалить станцию из маршрута
      6. Добавить маршрут для поезда
      7. Добавить вагон к поезду
      8. Отцепить вагон от поезда
      9. Показать все поезда на нужной станции
      10. Отправить поезд вперед по маршруту
      11. Отправить поезд назад по маршруту
      12. Использовать место в грузовом вагоне
      13. Использовать место в пассажирском вагоне
      14. Показать все станции
      15. Показать вагоны нужного поезда'
      x = gets.chomp
      case x
      when '1'
        create_train
      when '2'
        create_station
      when '3'
        create_route
      when '4'
        expand_route
      when '5'
        shorten_rute
      when '6'
        route_to_train
      when '7'
        expand_train
      when '8'
        shorten_train
      when '9'
        station_trains
      when '10'
        forward_train
      when '11'
        back_train
      when '12'
        take_space
      when '13'
        take_place
      when '14'
        new_stations.each { |station| puts station.name }
      when '15'
        show_vagons
      end
    end
  end
  # данные методы должны быть приватны, так как пользователю предоставлен интерфейс для управления

  private

  def create_train
    puts '
    1. Добавить грузовой поезд
    2. Добавить пассажирский поезд'
    x = gets.chomp
    case x
    when '1'
      puts 'Введите номер грузового поезда'
      number = gets.chomp
      number = CargoTrain.new(number)
      new_trains.append(number)
    when '2'
      puts 'Введите номер пассажирского поезда'
      number = gets.chomp
      number = PassengerTrain.new(number)
      new_trains.append(number)
    end
  rescue Exception => e
    puts e
    retry
  end

  def create_station
    puts 'Введите название новой станции'
    name = gets.chomp
    name = Station.new(name)
    new_stations.append(name)
  rescue Exception => e
    puts e
    retry
  end

  def create_route
    puts 'Введите название маршрута'
    route_name = gets.chomp
    puts 'Введите название первой станции в маршруте'
    first = gets.chomp
    puts 'Введите название последней станции в маршруте'
    last = gets.chomp
    route_name = Route.new(first, last)
    new_routes.append(route_name)
  rescue Exception => e
    puts e
    retry
  end

  def expand_route
    puts 'Введите название маршрута, где требуется добавить станцию'
    route = gets.chomp
    puts 'Введите название станции, которую хотите добавить'
    station = gets.chomp
    new_routes[route.to_i].add_station(new_stations[station.to_i])
  end

  def shorten_rute
    puts 'Введите название маршрута, где требуется удалить станцию'
    route = gets.chomp
    puts 'Введите название станции для удаления'
    station = gets.chomp
    new_routes[route.to_i].remove_station(new_stations[station.to_i])
  end

  def route_to_train
    puts 'Введите номер поезда, где требуется добавить маршрут'
    train = gets.chomp
    puts 'Введите название маршрута'
    route = gets.chomp
    new_trains[train.to_i].new_route(new_routes[route.to_i])
  end

  def expand_train
    puts 'Введите номер поезда, где требуется добавить вагон'
    train = gets.chomp
    if new_trains[train.to_i].type == 'cargo'
      new_vagon = CargoVagon.new
      new_trains[train.to_i].add_vagon(new_vagon)
    end
    if new_trains[train.to_i].type == 'passenger'
      new_vagon = PassengerVagon.new
      new_trains[train.to_i].add_vagon(new_vagon)
    end
  end

  def shorten_train
    puts 'Введите номер поезда, где требуется убрать вагон'
    train = gets.chomp
    new_trains[train.to_i].remove_vagon
  end

  def station_trains
    puts 'Введите название станции для отображения поездов на ней'
    station = gets.chomp
    block1 = proc { |train| puts 'Номер: ' + train.number.to_s + ' - ' + 
    'Тип: ' + train.type.to_s + 'Количество вагонов: ' + train.vagons.length.to_s}
    @stations[station.to_i].show_trains(block1)
  end

  def forward_train
    puts 'Введите номер поезда, который хотите отправить'
    train = gets.chomp
    new_trains[train.to_i].move_forward
  end

  def back_train
    puts 'Введите номер поезда, который хотите отправить'
    train = gets.chomp
    new_trains[train.to_i].move_back
  end

  def take_space
    puts 'Введите номер грузового поезда, у которого требуется занять объем'
    train = gets.chomp
    puts 'Введите номер вагона, у которого требуется занять объем'
    number = gets.chomp.to_i
    puts 'Введите объем, который требуется занять'
    space = gets.chomp.to_i
    @trains[train.to_i].vagon[number].take_up(space)
  end

  def take_place
    puts 'Введите номер грузового поезда, у которого требуется занять объем'
    train = gets.chomp
    puts 'Введите номер вагона, у которого требуется занять объем'
    number = gets.chomp.to_i
    @trains[train.to_i].vagons[number].take_place
  end

  def show_vagons
    puts 'Введите номер поезда, у которого нужно вывести список вагонов?'
    train = gets.chomp
    block2 =  proc { |vagon| puts 'Номер вагона:' + a.to_s + ' - ' + 
      'Тип вагона:' + vagon.type.to_s + ' - ' + 'Свободно' + vagon.free_places.to_s + 
      ' - ' + 'мест - Занято' + vagon.used_places.to_s; 'мест' }
    @trains[train.to_i].show_vagons(block2)
  end
end
