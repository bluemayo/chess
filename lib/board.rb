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
    @selected = nil
  end

  def create_pawn(row, column, color)
    @board[row][column] = Pawn.new([row, column], color)
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

  # Used to Move/Capture pieces
  def move(current_position, new_position)
    piece = access_board(current_position)
    update_board(current_position)
    update_board(new_position, piece)
    piece.update_position(new_position)
    piece.moved if piece.is_a?(Pieces::Pawn)
  end

  def update_board(position, piece = nil)
    @board[position[0]][position[1]] = piece
  end

  def access_board(position)
    @board[position[0]][position[1]]
  end

  def select_piece(position)
    @selected = access_board(position)
  end

  def possible
    @selected.possible_moves
  end
end
