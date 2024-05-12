# frozen_string_literal: true

require_relative 'pieces'

# This class will define the board of a chess game as a 2D array containing pieces as objects
# Class will also contain game logics involving the board such as check
class Board
  include Pieces
  # TDL: 1) @board should be an 8x8 2D array with top 2 and bottom 2 rows occupied when initialized
  #      2) Methods for a) Capturing
  #                     b) Castling
  #                     c) Check and Checkmate
  #                     d) En Passant
  #                     e) Draws like Stalement, Dead position, Threefold repetition, fifty-move rule
  #                     f) Serializing
  #      3) Method for updating a piece's position (communication with Pieces Module)
  def initialize
    @board = Array.new(8).map { Array.new(8) }
  end

  def init_pieces
    create_non_pawns(0)
    create_pawns(1)
    create_non_pawns(7)
    create_pawns(6)
  end

  def create_pawns(row)
    (0..7).each do |column|
      @board[row][column] = Pawn.new([row, column])
    end
  end

  def create_non_pawns(row)
    create_rook(row)
    create_knight(row)
    create_bishop(row)
    create_queen(row)
    create_king(row)
  end

  def create_rook(row)
    @board[row][0] = Rook.new([row, 0])
    @board[row][7] = Rook.new([row, 7])
  end

  def create_knight(row)
    @board[row][1] = Knight.new([row, 1])
    @board[row][6] = Knight.new([row, 6])
  end

  def create_bishop(row)
    @board[row][2] = Bishop.new([row, 2])
    @board[row][5] = Bishop.new([row, 5])
  end

  def create_queen(row)
    @board[row][3] = Queen.new([row, 3])
  end

  def create_king(row)
    @board[row][4] = King.new([row, 4])
  end
end
