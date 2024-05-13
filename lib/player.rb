# frozen_string_literal: true

# This class defines a player in a chess game
class Player
  def initialize(name)
    @name = name
    @pieces = []
    @selected = nil
  end

  def update_pieces(piece_position)
    @pieces << piece_position
  end

  def choose_piece
    print 'Select Piece: '
    to_row_and_column(gets.chomp)
  end

  def move_to
    print 'Move to: '
    to_row_and_column(gets.chomp)
  end

  private

  def to_row_and_column(file_and_rank)
    array = file_and_rank.split('').reverse
    array[0] = array[0].to_i - 1
    array[1] = array[1].downcase.ord - 'a'.ord
    array
  end
end
