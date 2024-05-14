# frozen_string_literal: true

# This module will contain the 6 types of chess pieces as Classes
# These classes will only dictate the movement of pieces and are not related to the game logic
module Pieces
  # Each pieces should have a @position as a [y, x] inherited from class Piece
  class Piece
    def initialize(position)
      @position = position
    end

    def update_position(new_position)
      @position = new_position
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

    def possible_moves
      array = []
      (-1..1).each do |column|
        new_column = @position[1] + column
        array << [@position[0] + @direction, new_column] unless new_column.negative? || new_column > 7
      end
      array << [@position[0] + 2 * @direction, @position[1]] if @start
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
        break if new_position.any? { |position| position.negative? || position > 7 }

        array << new_position
      end
      array
    end
  end

  class Bishop < Piece
    # TDL: 1) standard move: any number of sqs diagonally
    #      2) unable to move past pieces
  end

  class Rook < Piece
    # TDL: 1) standard move: any number of sqs updown leftright
    #      2) unable to move past pieces
    #      3) castling with King
  end

  class Queen < Piece
    # TDL: 1) standard move: any number of sqs updown leftright and diagonally
    #      2) unable to move past pieces
  end

  class King < Piece
    # TDL: 1) standard move: 1 sq in any direction
    #      2) castling with Rook
  end
end
