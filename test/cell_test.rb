require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/cell.rb'
require_relative '../lib/ship.rb'

class CellTest < Minitest::Test
  def setup
    @cell = Cell.new("A1")
  end

  def test_it_exist
    assert_instance_of Cell, @cell
  end

  def test_it_has_a_coordinate
    assert_equal "A1", @cell.coordinate
  end

  def test_not_assigned_to_a_ship_by_default
    assert_nil @cell.ship
  end

  def test_empty_method_shows_true_by_default
    assert_equal true, @cell.empty?
  end

  def test_place_ship_method
    ship = Ship.new('Cruiser', 3)
    @cell.place_ship(ship)
    assert_equal ship, @cell.ship
    assert_equal false, @cell.empty?
  end

  def test_fired_upon_method
    assert_equal false, @cell.fired_upon?
  end

  def test_fire_upon_method
    ship = Ship.new('Cruiser', 3)
    @cell.place_ship(ship)
    assert_equal false, @cell.fired_upon?
    assert_equal 3, @cell.ship.health
    @cell.fire_upon
    assert_equal true, @cell.fired_upon?
    assert_equal 2, @cell.ship.health
  end

  def test_render_method
    assert_equal ".", @cell.render
    @cell.fire_upon
    assert_equal "M", @cell.render

    cell2 = Cell.new("A2")
    assert_equal ".", cell2.render
    ship = Ship.new('Cruiser', 3)
    cell2.place_ship(ship)
    cell2.fire_upon
    assert_equal "H", cell2.render

    cell3 = Cell.new("A3")
    assert_equal ".", cell3.render
    ship2 = Ship.new('Dingy', 1)
    cell3.place_ship(ship2)
    cell3.fire_upon
    assert_equal "X", cell3.render

    cell4 = Cell.new("A4")
    assert_equal ".", cell4.render
    ship3 = Ship.new('Cruiser', 3)
    cell4.place_ship(ship3)
    assert_equal "S", cell4.render(true)
  end
end
