# frozen_string_literal: true

# This module will contain the 6 types of chess pieces as Classes
# These classes will only dictate the movement of pieces and are not related to the game logic
module Pieces
  # Each pieces should have a @position as a [y, x] inherited from class Piece
  class Piece
    attr_reader :position, :player

    def initialize(position)
      @position = position
      @player = calc_player
    end

    def update_position(new_position)
      @position = new_position
    end

    def calc_player
      case @position[0]
      when 1, 2
        1
      when 7, 8
        2
      else
        1
      end
    end
  end

  # Defines action of a pawn
  class Pawn < Piece
    # TDL: 1) standard move: 1 sq diagonally/straight forward
    #      2) initial move: able to move 2 sq forward
    #      3) only able to capture on diagonal moves
    #      4) en passant
    #      5) promotion
    def initialize(position, direction)
      super position
      @direction = direction
      @start = true
    end

    def to_s
      "\u2659".encode('UTF-8')
    end

    def possible_moves
      array = []
      (-1..1).each do |column|
        new_column = @position[1] + column
        array << [@position[0] + @direction, new_column] unless new_column < 1 || new_column > 8
      end
      array << [@position[0] + 2 * @direction, @position[1]] if @start
      array
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
        new_position = [@position[0] + move[0], @position[1] + move[1]]
        array << new_position unless new_position.any? { |position| position < 1 || position > 8 }
      end
      array
    end

    def to_s
      "\u2658".encode('UTF-8')
    end
  end

  # Defines the actions of a Bishop
  class Bishop < Piece
    # TDL: 1) standard move: any number of sqs diagonally
    #      2) unable to move past pieces
    def to_s
      "\u2657".encode('UTF-8')
    end

    def possible_moves
      # Returns a direction array
      [[1, 1], [1, -1], [-1, -1], [-1, 1]]
    end
  end

  # Defines the actions of a Rook
  class Rook < Piece
    # TDL: 1) standard move: any number of sqs updown leftright
    #      2) unable to move past pieces
    #      3) castling with King
    def to_s
      "\u2656".encode('UTF-8')
    end

    def possible_moves
      # Returns a direction array
      [[1, 0], [-1, 0], [0, 1], [0, -1]]
    end
  end

  # Defines the actions of a Queen
  class Queen < Piece
    # TDL: 1) standard move: any number of sqs updown leftright and diagonally
    #      2) unable to move past pieces
    def to_s
      "\u2655".encode('UTF-8')
    end

    def possible_moves
      [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [1, -1], [-1, -1], [-1, 1]]
    end
  end

  # Defines the actions of a King
  class King < Piece
    # TDL: 1) standard move: 1 sq in any direction
    #      2) castling with Rook
    def to_s
      "\u2654".encode('UTF-8')
    end
  end
end
