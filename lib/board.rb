require_relative './cell.rb'
require_relative './modules.rb'

class Board
  attr_reader :cells
  include Cell_Creation
  def initialize
    @cells = make_cells
  end

  def valid_coordinate? coor 
    @cells.keys.include? coor
  end

end