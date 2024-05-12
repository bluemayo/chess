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

  def create_pawn(row, column)
    @board[row][column] = Pawn.new([row, column])
  end

  def create_non_pawn(row, column) # rubocop: disable Metrics
    @board[row][column] = case column
                          when 0, 7
                            Rook.new([row, column])
                          when 1, 6
                            Knight.new([row, column])
                          when 2, 5
                            Bishop.new([row, column])
                          when 3
                            Queen.new([row, column])
                          when 4
                            King.new([row, column])
                          end
  end

  def move(current_position, new_position)
    piece = @board[current_position[0]][current_position[1]]
    @board[current_position[0]][current_position[1]] = nil
    @board[new_position[0]][new_position[1]] = piece
    piece.update_position(new_position)
  end
end
