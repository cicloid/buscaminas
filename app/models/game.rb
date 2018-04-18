class Game < ApplicationRecord
  serialize :board, BoardEncoder
  serialize :timers

  after_initialize :add_board

  def add_board
    if new_record?
      self.board ||= Board.new(level: difficulty || :beginner)
      self.difficulty ||= board.level.to_sym
      self.state = 'ongoing'
      board.boobytrap_the_board!
    end
  end

  def flag(row,col)
    return false if game_over?
    if board.flag(row.to_i, col.to_i)
      update_state
    else
      false
    end
  end

  def reveal(row,col)
    return false if game_over?
    if board.reveal(row.to_i, col.to_i)
      update_state
    else
      false
    end
  end


  def game_over?
    board.won? || board.lost?
  end

  def update_state
    state = 'finished' if game_over?
  end

end
