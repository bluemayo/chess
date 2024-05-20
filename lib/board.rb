# frozen_string_literal: true

require_relative 'pieces'

# This class will define the board of a chess game as a 2D array containing pieces as objects
# Class will also contain game logics involving the board such as check
class Board
  include Pieces

  attr_reader :selected

  def initialize
    @board = Array.new(9).map { Array.new(9) }
  end

  def []=(position, piece)
    row, column = position
    @board[row][column] = piece
  end

  def [](position)
    row, column = position
    @board[row][column]
  end

  def populate_board
    (1..8).each do |column|
      @board[2][column] = Pawn.new([2, column], :white, self)
      @board[7][column] = Pawn.new([7, column], :black, self)
      create_non_pawn(1, column, :white)
      create_non_pawn(8, column, :black)
    end
  end

  def create_non_pawn(row, column, color) # rubocop: disable Metrics
    @board[row][column] = case column
                          when 1, 8
                            Rook.new([row, column], color, self)
                          when 2, 7
                            Knight.new([row, column], color, self)
                          when 3, 6
                            Bishop.new([row, column], color, self)
                          when 4
                            Queen.new([row, column], color, self)
                          when 5
                            King.new([row, column], color, self)
                          end
  end

  # Used to Move/Capture with the selected piece
  def move(current_position, new_position)
    piece = self[current_position]
    self[current_position] = nil
    self[new_position] = piece
    piece.update_location(new_position)
  end

  def in_check?(color)
    king_position = pieces.select { |piece| piece.color == color && piece.is_a?(Pieces::King) }[0].location

    pieces.reject { |piece| piece.color == color }.each do |piece|
      return true if piece.possible_moves.include?(king_position)
    end
    false
  end

  def checkmate?(color)
    return false unless in_check?(color)

    all_pieces = pieces.select { |piece| piece.color == color }
    all_pieces.all? { |piece| piece.valid_moves.empty? }
  end

  # Returns all pieces
  def pieces
    @board.flatten.reject(&:nil?)
  end

  # Creates a duplicate board with diff instances
  def dup
    new_board = Board.new
    pieces.each do |piece|
      new_piece = piece.class.new(piece.location, piece.color, new_board)
      new_board[new_piece.location] = new_piece
    end
    new_board
  end
end
