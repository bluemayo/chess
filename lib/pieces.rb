# frozen_string_literal: true

require_relative 'board'

# This module will contain the 6 types of chess pieces as Classes
# These classes will only dictate the movement of pieces and are not related to the game logic
module Pieces
  # Each pieces should have a @position as a [y, x] inherited from class Piece
  class Piece
    attr_reader :location, :color, :board

    def initialize(location, color, board)
      @location = location
      @color = color
      @board = board
    end

    def valid_moves
      moves = []
      possible_moves.each do |move|
        new_board = board.dup
        new_board.move(location, move)
        moves << move unless new_board.in_check?(color)
      end
      moves
    end

    def enemy?(position)
      return false unless inbounds?(position)

      !board[position].nil? && board[position].color != color
    end

    def empty?(position)
      return false unless inbounds?(position)

      board[position].nil?
    end

    def inbounds?(position)
      position.all? { |rowcolumn| rowcolumn.positive? && rowcolumn < 9 }
    end

    def check_direction(direction, position, array = [])
      new_position = [position[0] + direction[0], position[1] + direction[1]]
      if empty?(new_position)
        array << new_position
        check_direction(direction, new_position, array)
      elsif enemy?(new_position)
        array << new_position
      end
      array
    end

    def update_location(new_position)
      @location = new_position
    end
  end

  # Defines action of a pawn
  class Pawn < Piece
    # TDL: 1) standard move: 1 sq diagonally/straight forward
    #      2) initial move: able to move 2 sq forward
    #      3) only able to capture on diagonal moves
    #      4) en passant
    #      5) promotion
    def initialize(location, color, board)
      super(location, color, board)
      @start = true
    end

    def to_s
      color == :white ? "\u2659".encode('UTF-8') : "\u265F".encode('UTF-8')
    end

    def possible_moves(array = []) # rubocop: disable Metrics/AbcSize, Metrics/MethodLength
      (-1..1).each do |column|
        new_position = [location[0] + direction, location[1] + column]
        if empty?(new_position)
          array << new_position
        elsif enemy?(new_position)
          array << new_position unless new_position[1] == location[1]
        end
      end
      new_position = [location[0] + 2 * direction, location[1]]
      array << new_position if @start && empty?(new_position)
      array
    end

    def direction
      color == :white ? 1 : -1
    end

    def moved
      @start = false
    end
  end

  # Defines the actions of a Knight
  class Knight < Piece
    # TDL: 1) standard move: L-shaped traversal
    #      2) able to leap past any pieces
    MOVES = [[2, -1], [2, 1], [1, -2], [1, 2], [-1, -2], [-1, 2], [-2, -1], [-2, 1]].freeze

    def possible_moves
      array = []
      MOVES.each do |move|
        new_position = [location[0] + move[0], location[1] + move[1]]
        array << new_position if empty?(new_position) || enemy?(new_position)
      end
      array
    end

    def to_s
      color == :white ? "\u2658".encode('UTF-8') : "\u265E".encode('UTF-8')
    end
  end

  # Defines the actions of a Bishop
  class Bishop < Piece
    # TDL: 1) standard move: any number of sqs diagonally
    #      2) unable to move past pieces
    DIRECTIONS = [[1, 1], [1, -1], [-1, -1], [-1, 1]].freeze

    def to_s
      color == :white ? "\u2657".encode('UTF-8') : "\u265D".encode('UTF-8')
    end

    def possible_moves
      array = []
      DIRECTIONS.each do |direction|
        array.concat check_direction(direction, location)
      end
      array
    end
  end

  # Defines the actions of a Rook
  class Rook < Piece
    # TDL: 1) standard move: any number of sqs updown leftright
    #      2) unable to move past pieces
    #      3) castling with King
    DIRECTIONS = [[1, 0], [-1, 0], [0, 1], [0, -1]].freeze

    def to_s
      color == :white ? "\u2656".encode('UTF-8') : "\u265C".encode('UTF-8')
    end

    def possible_moves
      array = []
      DIRECTIONS.each do |direction|
        array.concat check_direction(direction, location)
      end
      array
    end
  end

  # Defines the actions of a Queen
  class Queen < Piece
    # TDL: 1) standard move: any number of sqs updown leftright and diagonally
    #      2) unable to move past pieces
    DIRECTIONS = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [1, -1], [-1, -1], [-1, 1]].freeze

    def to_s
      color == :white ? "\u2655".encode('UTF-8') : "\u265B".encode('UTF-8')
    end

    def possible_moves
      array = []
      DIRECTIONS.each do |direction|
        array.concat check_direction(direction, location)
      end
      array
    end
  end

  # Defines the actions of a King
  class King < Piece
    # TDL: 1) standard move: 1 sq in any direction
    #      2) castling with Rook
    MOVES = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [1, -1], [-1, -1], [-1, 1]].freeze

    def to_s
      color == :white ? "\u2654".encode('UTF-8') : "\u265A".encode('UTF-8')
    end

    def possible_moves
      array = []
      MOVES.each do |move|
        new_position = [location[0] + move[0], location[1] + move[1]]
        array << new_position if empty?(new_position) || enemy?(new_position)
      end
      array
    end
  end
end
