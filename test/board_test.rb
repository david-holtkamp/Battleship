require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/board.rb'
require_relative '../lib/cell.rb'
require_relative '../lib/ship.rb'



class BoardTest < Minitest::Test 
  def setup
    @board = Board.new
  end
  
  def test_it_exists
    assert_instance_of Board, @board
  end
  
  def test_cells_is_a_hash
    assert_instance_of Hash, @board.cells
    assert_equal 16, @board.cells.length
    assert_instance_of Cell, @board.cells.values[4]
  end

  def test_validate_coordinate_method
    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal false, @board.valid_coordinate?("E1")
  end

  def test_validate_placement_method_for_length_check
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    
    assert_equal false, @board.length(cruiser, ["A1", "A2"])
    assert_equal true, @board.length(cruiser, ["A1", "A2", "A3"])

    assert_equal true, @board.length(submarine, ["A1", "A2"])
    assert_equal false, @board.length(submarine, ["A1", "A2", "A3"])
  end

  def test_validate_placement_method_for_consecutive_coordinates
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, @board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, @board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    assert_equal false, @board.valid_placement?(cruiser, ["C1", "B1", "B1"])

    assert_equal true, @board.valid_placement?(cruiser, ["A1", "A2", "A3"])
    assert_equal true, @board.valid_placement?(cruiser, ["A1", "B1", "C1"])
    assert_equal true, @board.valid_placement?(cruiser, ["B2", "C2", "D2"])

    assert_equal false, @board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, @board.valid_placement?(cruiser, ["B2", "C3", "D4"])

    assert_equal false, @board.valid_placement?(cruiser, ["A1", "A3"])
    assert_equal false, @board.valid_placement?(cruiser, ["A4", "A5"])
    assert_equal false, @board.valid_placement?(cruiser, ["A4", ""])
    assert_equal false, @board.valid_placement?(cruiser, [])
    assert_equal true, @board.valid_placement?(submarine, ["A1", "A2"])
    assert_equal true, @board.valid_placement?(submarine, ["A1", "B1"])
  end
end