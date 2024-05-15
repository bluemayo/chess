# frozen_string_literal: true

require_relative 'display'

# This class defines a player in a chess game
class Player
  include Display

  def initialize(name)
    @name = name
    @pieces = []
    @selected = nil
  end

  def update_pieces(piece)
    @pieces << piece
  end

  def delete_piece(piece)
    p piece
    @pieces.delete(piece) unless piece.nil?
  end

  def choose_piece
    print 'Select Piece: '
    move = check_move
    return move if owned?(move)

    display_not_owned
    choose_piece
  end

  def move_to
    print 'Move to: '
    check_move
  end

  private

  def check_move
    move = to_row_and_column(gets.chomp)
    return move if in_range?(move)

    display_invalid
    move_to
  end

  def to_row_and_column(file_and_rank)
    return [0, 0] unless file_and_rank.length == 2

    array = file_and_rank.split('').reverse
    array[0] = array[0].to_i
    array[1] = array[1].downcase.ord - 'a'.ord + 1
    array
  end

  def in_range?(position)
    position.each { |each| return false if each < 1 || each > 8 }
    true
  end

  def owned?(position)
    @pieces.each do |piece|
      return true if piece.instance_variable_get(:@position) == position
    end
    false
  end
end
