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
end
