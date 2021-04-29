# frozen_string_literal: true

class PassengerVagon < Vagon
  attr_reader :free_places, :used_places
  def initialize(free_places)
  	@free_places = free_places
    @used_places = 0
    super
    @type = 'passenger'
  end
  
  def take_place
    @used_places += 1
    @free_places -=  1
  end  
end
