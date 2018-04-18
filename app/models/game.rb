class Game < ApplicationRecord
  serialize :board

  after_initialize :add_board

  def add_board
    self.board ||= Board.new(level: @difficulty || :beginner) if new_record?
    self.difficulty ||= self.board.level.to_sym if new_record
  end


end
