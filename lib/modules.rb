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