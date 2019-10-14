require_relative './cell.rb'
require_relative './modules.rb'

class Board
  attr_reader :cells
  include Cell_Creation
  def initialize
    @cells = make_cells
  end

  def valid_coordinate?(coor) 
    @cells.keys.include? coor
  end

  def valid_placement?(ship, coors)
    valid = coors.map {|coor| valid_coordinate?(coor)}
    no_ships = coors.map do |coor| 
      if @cells[coor]
      @cells[coor].empty?
      end
    end
    length(ship, coors) && order(ship, coors) && valid.all? && no_ships.all? 
  end

  def length(ship, coors)
    ship.length == coors.count
  end

  def order(ship, coors)
    horizontal = make_horizontal(coors)
    vertical = make_vert(coors)
    
    coors == horizontal || coors == vertical
  end

  def make_horizontal(coors)
    coor = [coors[0]]
    
    def increment(num, coor)
      coor << coor[num].succ
    end

    (coors.count-1).times do |i|
      increment(i, coor)
    end
    coor 
  end

  def make_vert(coors)
    coor = [coors[0]]
    
    def increment(num, coor)
      coor << coor[num].split('')[0].succ + coor[0].split('')[1]
    end

    (coors.count-1).times do |i|
      increment(i, coor)
    end
    coor 
  end

end