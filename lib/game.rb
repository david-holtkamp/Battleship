require_relative './board.rb'
require_relative './ship.rb'

class Game
  attr_reader :cpu_board, :cpu_cruiser, :cpu_submarine, :player_board, :player_cruiser, :player_submarine 
  include Cell_Creation
  include Text_Lines
  def initialize
    @cpu_board = nil
    @cpu_cruiser = Ship.new("Cruiser", 3)
    @cpu_submarine = Ship.new("Submarine", 2)
    @player_board = nil
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
  end

  def welcome
    puts msg(1)
    print msg(2)
  end

  def run_game
    cpu_setup
    render_boards
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

  def winner? 
    if game.cpu_cruiser.sunk? && game.cpu_submarine.sunk?
      puts "Congrats You Won!"
    elsif game.player_cruiser.sunk? && game.player_submarine.sunk?
      puts "You Lose"
    end
  end
end