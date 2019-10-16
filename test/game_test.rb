require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/game.rb'
require_relative '../lib/ship.rb'
require_relative '../lib/board.rb'

class Gametest < Minitest::Test 
  def setup
    @game = Game.new
  end

  def test_it_exist
    assert_instance_of Game, @game
  end

  def test_initial_values
    assert_nil @game.cpu_board
    assert_nil @game.player_board
    assert_equal "Cruiser", @game.cpu_cruiser.name
    assert_equal "Cruiser", @game.player_cruiser.name
    assert_equal "Submarine", @game.cpu_submarine.name
    assert_equal "Submarine", @game.player_submarine.name
    assert_equal 3, @game.cpu_cruiser.length
    assert_equal 3, @game.player_cruiser.length
    assert_equal 2, @game.cpu_submarine.length
    assert_equal 2, @game.player_submarine.length
  end

  def test_hit_msg_me
    assert_equal "Player's shot on A1 was a hit and sunk the ship!", @game.hit_msg("X", "A1", "Player's")
    assert_equal "Player's shot on A1 hit a ship!", @game.hit_msg("H", "A1", "Player's")
  end

  def test_check_coor_method
    board = Board.new
    assert_equal "A1", @game.check_coor("A1", board)
  end

  def test_cpu_setup
    assert_nil @game.cpu_board
    assert_nil @game.player_board

    @game.cpu_setup

    assert_instance_of Board, @game.cpu_board
    assert_instance_of Board, @game.player_board
  end

  def test_vert_method
    @game.cpu_setup
    ship = Ship.new("Cruiser", 3)
    ship2 = Ship.new("Cruiser", 2)

    assert_equal 3, @game.vert(ship).count
    assert_instance_of Array, @game.vert(ship) 
    assert_equal 2, @game.vert(ship2).count
    assert_instance_of Array, @game.vert(ship2)

  end

  def test_horizontal_method
    @game.cpu_setup
    ship = Ship.new("Cruiser", 3)
    ship2 = Ship.new("Cruiser", 2)

    assert_equal 3, @game.horizontal(ship).count
    assert_instance_of Array, @game.vert(ship)
    assert_equal 2, @game.horizontal(ship2).count
    assert_instance_of Array, @game.vert(ship2)
  end

  def test_player_placement
    ship = Ship.new("Cruiser", 3)
    @game.cpu_setup
    @game.player_placement(ship, ["A1", "A2", "A3"])
    assert_equal ship, @game.player_board.cells["A1"].ship
    assert_equal ship, @game.player_board.cells["A2"].ship
    assert_equal ship, @game.player_board.cells["A3"].ship
  end
end