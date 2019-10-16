require_relative './board.rb'
require_relative './cell.rb'
require_relative './ship.rb'
require_relative './game.rb'
require_relative './turn.rb'
include Text_Lines

game = Game.new
game.welcome
play = gets.chomp

def start_game play, game

  if play.upcase == "P"
    puts msg(3)
    game.run_game
    puts msg(5)

    cruiser_coors = gets.chomp.split(" ").map(&:upcase)
    game.player_placement(game.player_cruiser, cruiser_coors)
    game.render_boards(true)
    puts msg(6)

    sub_coors = gets.chomp.split(" ").map(&:upcase)
    game.player_placement(game.player_submarine, sub_coors)
    game.render_boards(true)
    msg(7)

    turn = Turn.new
    result = game.toggle_turns(turn)
    if result == "Y"
      new_game = Game.new
      start_game("P", new_game)
    else
      puts msg(4)
    end
  else
    puts msg(4)
  end

end

start_game(play, game)
