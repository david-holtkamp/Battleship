require './lib/modules'
class Turn
  attr_reader :coors
  attr_accessor :player_turn
  include Cell_Creation
  include Text_Lines
  def initialize
    @player_turn = true
    @coors = coors_list
  end

  def take_turn
    if @player_turn
      @player_turn = !@player_turn
      puts msg(8)
      location = gets.chomp
    else
      @player_turn = !@player_turn
      pick = @coors.sample
      @coors.delete(pick)
      pick
    end
  end
end
