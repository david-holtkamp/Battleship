require_relative './board.rb'
require_relative './cell.rb'
require_relative './ship.rb'

class Game
  attr_reader :cpu_board, :cpu_cruiser, :cpu_submarine, :player_board, :player_cruiser, :player_submarine 
  include Cell_Creation
  def initialize
    @cpu_board = nil
    @cpu_cruiser = Ship.new("Cruiser", 2)
    @cpu_submarine = Ship.new("Submarine", 3)
    @player_board = nil
    @player_cruiser = Ship.new("Cruiser", 2)
    @player_submarine = Ship.new("Submarine", 3)
  end

  def welcome
    puts "Welcome to BATTLESHIP!"
    print "Press P to play. Press Q to quit. "
  end

  def ready_to_play? play
    if play.upcase == "P"
      puts "Well then let's play!"
      cpu_setup
    else
      puts "Thanks for playing!"
    end
  end

  def cpu_setup
    @player_board = Board.new
    @cpu_board = Board.new
    create_coors(@cpu_cruiser)
    create_coors(@cpu_submarine)
  end

  def create_coors ship
    horiz = horizontal(ship)
    vertical = vert(ship) 
    coors = [horiz, vertical].sample
    @cpu_board.place(ship, coors)
    p coors
  end

  def vert ship
    start = [coors_list.sample]
    def increment(num, start)
      start << start[num].split('')[0].succ + start[num].split('')[1]
    end

    (ship.length-1).times do |i|
      increment(i, start)
    end
    if !@cpu_board.valid_placement?(ship,start)
      vert(ship)
    else
      start
    end
  end

  def horizontal ship
    start = [coors_list.sample]
    def increment(num, start)
      start << start[num].succ
    end

    (ship.length-1).times do |i|
      increment(i, start)
    end
    if !@cpu_board.valid_placement?(ship,start)
      horizontal(ship)
    else
      start
    end
  end

  def render_boards(bool = false)
    puts "*****CPU BOARD*****"
    puts @cpu_board.render
    puts "*****PLAYER BOARD*****"
    puts @player_board.render(bool)
  end

  def player_placement ship, coor
    if !@player_board.valid_placement?(ship, coor)
      print "You input an invalid set of coordinates. Please follow the the Rules for Placement and resubmit:  "
      coors = gets.chomp.split(" ").map(&:upcase)
      player_placement(ship, coors)
    else
      @player_board.place(ship, coor)
      puts "Thank You!"
    end
  end
end

game = Game.new
game.welcome
play = gets.chomp
game.ready_to_play?(play)
game.render_boards

puts "You have two ships to place. One is a cruiser with a length of 2 and the other is a submarine with a length of 3."
puts "***Rules for Placement***"
puts "Coordinates must be in sequential order either horizonatally or vertically."
print "Please input the coordinates for your cruiser seperating them by a single space:  "
cruiser_coors = gets.chomp.split(" ").map(&:upcase)
game.player_placement(game.player_cruiser, cruiser_coors)
game.render_boards(true)

print "Please input the coordinates for your submarine seperating them by a single space:  "
sub_coors = gets.chomp.split(" ").map(&:upcase)
game.player_placement(game.player_submarine, sub_coors)
game.render_boards(true)

p cruiser_coors
p sub_coors