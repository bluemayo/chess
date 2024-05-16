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
    @board = Array.new(9).map { Array.new(9) }
    @selected = nil
    @possible = nil
  end

  # Populate a row of pawns
  def create_pawn(row, column, direction)
    @board[row][column] = Pawn.new([row, column], direction)
  end

  # Populate non_pawns
  def create_non_pawn(row, column) # rubocop: disable Metrics
    @board[row][column] = case column
                          when 1, 8
                            Rook.new([row, column])
                          when 2, 7
                            Knight.new([row, column])
                          when 3, 6
                            Bishop.new([row, column])
                          when 4
                            Queen.new([row, column])
                          when 5
                            King.new([row, column])
                          end
  end

  # Used to Move/Capture with the selected piece
  def move(new_position)
    update_board(@selected.position)
    deleted_piece = update_board(new_position, @selected)
    @selected.update_position(new_position)
    @selected.moved if @selected.is_a?(Pieces::Pawn)
    puts "#{@selected} moved! to #{new_position}"
    deleted_piece
  end

  def update_board(position, piece = nil)
    deleted_piece = @board[position[0]][position[1]]
    @board[position[0]][position[1]] = piece
    deleted_piece
  end

  def access_board(position)
    # Remove the guard clause if not required as all input will be checked in Player class
    position.each { |each| return nil if each < 1 || each > 8 }
    @board[position[0]][position[1]]
  end

  # To change selected piece
  def select_piece(position)
    @selected = access_board(position)
    update_possible
    puts "#{@selected} at #{position} selected!"
  end

  # To call the possible function according to class, updating @possible with the return value
  def update_possible
    @possible = case @selected
                in Pieces::Pawn then pawn_possible
                in Pieces::Knight then knight_possible
                in Pieces::Bishop then bishop_possible
                in Pieces::Rook then rook_possible
                in Pieces::Queen then queen_possible
                in Pieces::King then king_possible
                end
  end

  private

  def pawn_possible
    array = []
    @selected.possible_moves.each do |move|
      piece = access_board(move)
      if piece.nil?
        array << move
      elsif piece.player != @selected.player && piece.position[1] != @selected.position[1]
        array << move
      end
    end
    array
  end

  def knight_possible
    array = []
    @selected.possible_moves.each do |move|
      piece = access_board(move)
      if piece.nil?
        array << move
      elsif piece.player != @selected.player
        array << move
      end
    end
    array
  end

  def bishop_possible
    array = []
    @selected.possible_moves.each do |direction|
      direction_array = check_direction(direction, @selected.position)
      array.concat(direction_array) unless direction_array.nil?
    end
    p array
    array
  end

  def rook_possible; end
  def queen_possible; end
  def king_possible; end

  def check_direction(direction, position, array = [])
    new_position = [position[0] + direction[0], position[1] + direction[1]]
    return array if new_position.any? { |each| return nil if each < 1 || each > 8 }

    piece = access_board(new_position)
    if piece.nil?
      array << new_position
      check_direction(direction, new_position, array)
    elsif piece.player != @selected.player
      array << new_position
    end
    array
  end
end
