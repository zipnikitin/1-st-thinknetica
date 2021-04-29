# frozen_string_literal: true

require_relative 'modules'

class CargoVagon < Vagon
  attr_reader :used_space, :free_space
  def initialize(free_space)
    @free_space = free_space
    @used_space = 0
    super
    @type = 'cargo'
  end

  def take_up(space)
    @used_space += space
    @free_space -=  space
  end
end
