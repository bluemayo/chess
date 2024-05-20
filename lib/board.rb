# frozen_string_literal: true

require_relative 'pieces'
require_relative 'display'

# This class will define the board of a chess game as a 2D array containing pieces as objects
# Class will also contain game logics involving the board such as check
class Board
  include Pieces
  include Display

  attr_reader :board, :selected

  def initialize
    @board = Array.new(9).map { Array.new(9) }
    @selected = nil
    populate_board
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
  def move(new_position)
    self[selected.location] = nil
    self[new_position] = selected
    selected.update_location(new_position)
  end

  def select_piece(position)
    @selected = self[position]
    puts "#{selected} selected!"
  end
end
