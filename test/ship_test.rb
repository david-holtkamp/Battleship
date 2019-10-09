require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/ship.rb'

class ShipTest < Minitest::Test
  def setup
    @ship = Ship.new('Cruiser', 3)
  end
  def test_it_exist
    assert_instance_of Ship, @ship
  end

  def test_it_has_a_name
    assert_equal "Cruiser", @ship.name
  end

  def test_it_has_a_correct_length
    assert_equal 3, @ship.length
  end

  def test_health_equal_to_length
    ship2 = Ship.new('Tugboat', 2)
    assert_equal 3, @ship.health
    assert_equal 2, ship2.health
  end

  def test_it_starts_as_not_sunk
    assert_equal false, @ship.sunk?
  end

  def test_health_is_lost_when_hit
    assert_equal 3, @ship.health
    @ship.hit
    assert_equal 2, @ship.health
  end

  def test_ship_is_sunk_when_health_is_zero
    assert_equal 3, @ship.health
    assert_equal false, @ship.sunk?
    @ship.hit
    assert_equal 2, @ship.health
    assert_equal false, @ship.sunk?
    @ship.hit
    assert_equal 1, @ship.health
    assert_equal false, @ship.sunk?
    @ship.hit
    assert_equal 0, @ship.health
    assert_equal true, @ship.sunk?
  end
end
