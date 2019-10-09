require 'pry'
class Cell
attr_reader :coordinate, :ship, :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    if @ship
      false
    else
      true
    end
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    if @ship
      @ship.hit
    end
  end

  def render
    if !@ship && !@fired_upon
      "."
    elsif @fired_upon && @ship && @ship.sunk?
      "X"
    elsif @fired_upon && @ship && @ship.health < @ship.length
      "H"
    elsif @fired_upon && !@ship
      "M"
    end
  end
end
