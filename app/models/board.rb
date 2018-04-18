class Board
  attr_accessor :rows, :cols, :grid, :mines

  SURROUND = [-1, 0, 1].product([-1, 0, 1]) - [[0, 0]]

  DIFFICULTY = {
    test: [3, 3, 1],
    beginner: [8, 8, 10],
    intermediate: [16, 16, 40],
    advanced: [24, 24, 99]
  }

  def initialize(level: :beginner)
    @rows, @cols, @mines = DIFFICULTY[level.to_sym]
    @level = level

    @grid = Array.new(@rows) {|row|
      Array.new(@cols) {|col|
        Cell.new(row, col)
      }
    }
  end

  def lost?
    @lost
  end

  def won?
    unopened_cells = @grid.flatten.reject(&:revealed?).size
    unopened_cells == @mines
  end

  def boobytrap_the_board!
    current_mines = 0
    while current_mines < @mines
      rand_row = rand(@rows)
      rand_col = rand(@cols)

      cell = @grid[rand_row][rand_col]
      unless cell.boobytrapped?
        cell.mine = true
        current_mines += 1
      end
    end
  end

  def reveal(row, col)
    if @grid[row][col].boobytrapped?
      @lost = true
      @grid[row][col].reveal!
    else
      reveal_tiles(row, col)
    end
  end

  def flag(row, col)
    cell = @grid[row][col]
    return if cell.revealed?

    cell.toggle_flag!
  end

  def get_adjecent_mines(row, col)
    neighbors = find_neighbors(row, col)
    neighbors.each do |neighbor|
      row2, col2 = neighbor
      @grid[row][col].adjacent_mines += 1 if @grid[row2][col2].boobytrapped?
    end
    @grid[row][col].adjacent_mines
  end

  def reveal_tiles(row, col)
    return if @grid[row][col].flagged?
    @grid[row][col].reveal!
    cell_mines = get_adjecent_mines(row, col)
    return if cell_mines > 0
    neighbors = find_neighbors(row, col)
    neighbors.each do |row, col|
      reveal_tiles(row, col) unless @grid[row][col].revealed? || @grid[row][col].boobytrapped?
    end
  end

  def find_neighbors(row, col)
    neighbors = []
    SURROUND.each do |pos|
      drow, dcol = [pos[0]+row, pos[1]+col]
      neighbors << [drow, dcol] unless out_of_bounds?(drow, dcol)
    end
    neighbors
  end

  def collect_cells_hashes
    @grid.collect do |cols|
      row = cols.collect do |cell|
        cell.to_hash
      end
    end
  end

  def to_json
    {
      'difficulty': @level,
      'rows': @rows,
      'cols': @cols,
      'cells': collect_cells_hashes
    }.to_json
  end

  def to_s
    string = []
    @grid.each do |cols|
      row = cols.collect do |cell|
        if cell.boobytrapped? && cell.revealed?
          "M"
        elsif cell.flagged?
          "F"
        elsif cell.adjacent_mines > 0 && cell.revealed?
          cell.adjacent_mines
        elsif cell.revealed?
          " "
        else
          "-"
        end
      end
      string << "#{row.join}"
    end
    string.join("\r\n")
  end

  def out_of_bounds?(row, col)
    # TODO: This should be more specific, since the board is a square, there
    # is no problem for now
    [row, col].any? { |el| el < 0  || (el > @rows - 1)}
  end
end
