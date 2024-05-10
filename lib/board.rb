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
    init_pieces
  end

  private

  def init_pieces
    create_non_pawns(0, :white)
    create_pawns(1, :white)
    create_non_pawns(7, :black)
    create_pawns(6, :black)
  end

  def create_pawns(row, color)
    (0..7).each do |column|
      @board[row][column] = Pawn.new([row, column], color)
    end
  end

  def create_non_pawns(row, color)
    create_rook(row, color)
    create_knight(row, color)
    create_bishop(row, color)
    create_queen(row, color)
    create_king(row, color)
  end

  def create_rook(row, color)
    @board[row][0] = Rook.new([row, 0], color)
    @board[row][7] = Rook.new([row, 7], color)
  end

  def create_knight(row, color)
    @board[row][1] = Knight.new([row, 1], color)
    @board[row][6] = Knight.new([row, 6], color)
  end

  def create_bishop(row, color)
    @board[row][2] = Bishop.new([row, 2], color)
    @board[row][5] = Bishop.new([row, 5], color)
  end

  def create_queen(row, color)
    @board[row][3] = Queen.new([row, 3], color)
  end

  def create_king(row, color)
    @board[row][4] = King.new([row, 4], color)
  end
end
