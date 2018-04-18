class Cell
  attr_accessor :x, :y, :mine, :revealed, :flagged, :adjacent_mines

  class << self
    def load(hash)
      n = new hash['x'], hash['y'], hash['mine']
      n.revealed = hash['revealed']
      n.flagged = hash['flagged']
      n.adjacent_mines = hash['adjacent_mines']
    end
  end

  def initialize(x, y, mine = false)
    @x = x
    @y = y
    @mine = mine
    @revealed = false
    @flagged = false
    @adjacent_mines = 0
  end

  def boobytrapped?
    @mine == true
  end

  def flagged?
    @flagged == true
  end

  def revealed?
    @revealed == true
  end

  def unrevealed?
    @revealed == false
  end

  def reveal!
    @revealed = true
  end

  def toggle_flag!
    @flagged = !@flagged
  end

  def to_hash
    {
      'x': @x,
      'y': @y,
      'mine': @mine,
      'revealed': @revealed,
      'flagged': @flagged
    }
  end

end
