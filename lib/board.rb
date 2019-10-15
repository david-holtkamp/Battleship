require_relative './cell.rb'
require_relative './modules.rb'
require_relative './ship'
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
      coor << coor[num].split('')[0].succ + coor[num].split('')[1]
    end

    (coors.count-1).times do |i|
      increment(i, coor)
    end
    coor
  end

  def place(ship, coors)
    if valid_placement?(ship,coors)
      coors.each do |coor|
        @cells[coor].place_ship(ship)
      end
    end
  end

  def render(bool = false)
      "  1 2 3 4 \n" +
      "A #{@cells["A1"].render(bool)} #{@cells["A2"].render(bool)} #{@cells["A3"].render(bool)} #{@cells["A4"].render(bool)} \n" +
      "B #{@cells["B1"].render(bool)} #{@cells["B2"].render(bool)} #{@cells["B3"].render(bool)} #{@cells["B4"].render(bool)} \n" +
      "C #{@cells["C1"].render(bool)} #{@cells["C2"].render(bool)} #{@cells["C3"].render(bool)} #{@cells["C4"].render(bool)} \n" +
      "D #{@cells["D1"].render(bool)} #{@cells["D2"].render(bool)} #{@cells["D3"].render(bool)} #{@cells["D4"].render(bool)} \n"
  end
end
