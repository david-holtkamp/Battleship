module Cell_Creation
  def make_cells
    coor_list = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    board_cells = coor_list.inject({}) do |acc, coor|
      acc[coor] = Cell.new(coor)
    acc
    end
    board_cells
  end

  def coors_list
    coors_list = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
  end
end

module Text_Lines
  def msg num
    msg = {
      1 => "Welcome to BATTLESHIP!",
      2 => "Press P to play. Press Q to quit. ",
      3 => "Well then let's play",
      4 => "Thanks for playing!",
      5 => "You have two ships to place. One is a cruiser with a length of 3 and the other is a submarine with a length of 2 \n" +
      "***Rules for Placement*** \n" +
      "Coordinates must be in sequential order either horizonatally or vertically. \n" +
      "Please input the coordinates for your cruiser seperating them by a single space:  ",
      6 => "Please input the coordinates for your submarine seperating them by a single space:  ",
      7 => "All ships have been placed",
      8 => "Player, please select a coordinate to fire upon:  ",
      9 => "Would you like to play again Y/N?  ",
      10 => "That is not a valid coordinate please choose a new coordinate.",
      11 => "IIIIIIDIOT YOU ALREADY SHOT THERE. TRY AGAIN YOU TROGLODYTE."
    }
    msg[num]
  end
end