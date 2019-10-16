require 'minitest/autorun'
require 'minitest/pride'
require './lib/turn'
require 'minitest'

class TurnTest < Minitest::Test

  def setup
    @turn = Turn.new
  end

  def test_it_exist
    assert_instance_of Turn, @turn
  end

  def test_initial_values
    assert_equal true, @turn.player_turn
    assert_equal 16, @turn.coors.count
    assert_instance_of Array, @turn.coors
  end

  def test_you_can_take_turn
    @turn.player_turn = false

    @turn.take_turn

    assert_equal true, @turn.player_turn
    assert_equal 15, @turn.coors.count 
  end

end
