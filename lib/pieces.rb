# frozen_string_literal: true

# This module will contain the 6 types of chess pieces as Classes
# These classes will only dictate the movement of pieces and are not related to the game logic
module Pieces
  class Pawn
    # TDL: 1) standard move: 1 sq diagonally/straight forward
    #      2) initial move: able to move 2 sq forward
    #      3) only able to capture on diagonal moves
    #      4) en passant
    #      5) promotion
  end

  class Knight
    # TDL: 1) standard move: L-shaped traversal
    #      2) able to leap past any pieces
  end

  class Bishop
    # TDL: 1) standard move: any number of sqs diagonally
    #      2) unable to move past pieces
  end

  class Rook
    # TDL: 1) standard move: any number of sqs updown leftright
    #      2) unable to move past pieces
    #      3) castling with King
  end

  class Queen
    # TDL: 1) standard move: any number of sqs updown leftright and diagonally
    #      2) unable to move past pieces
  end

  class King
    # TDL: 1) standard move: 1 sq in any direction
    #      2) castling with Rook
  end
end
