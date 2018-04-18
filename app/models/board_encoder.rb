class BoardEncoder
  def self.load(value)
    return Board.new if value.blank?
    parsed = JSON.load(value)
    board = Board.new(level: parsed['difficulty'].to_sym)
    parsed['cells'].each do |row|
      row.each do |pcell|
        x, y = pcell['x'], pcell['y']
        cell = board.grid[x][y]
        cell.mine = pcell['mine'] || false
        cell.revealed = pcell['revealed'] || false
        cell.flagged = pcell['flagged'] || false
        cell.adjacent_mines = pcell['adjacent_mines'] || 0
      end
    end
    board.grid.flatten.map {|cell| board.get_adjecent_mines(cell.x, cell.y)}
    board
  end

  def self.dump(value)
    value.to_json
  end

end
