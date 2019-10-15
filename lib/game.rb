require_relative './board.rb'
require_relative './cell.rb'
require_relative './ship.rb'

class Game
  include Cell_Creation
  def initialize
    @cpu_board = nil
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
    @cpu_board = Board.new
    cpu_cruiser = Ship.new("Cruiser", 2)
    cpu_submarine = Ship.new("Submarine", 3)
    create_coors(cpu_cruiser)
    create_coors(cpu_submarine)
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
end

game = Game.new
game.welcome
play = gets.chomp
game.ready_to_play?(play)

