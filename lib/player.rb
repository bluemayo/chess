# frozen_string_literal: true

# This class defines a player in a chess game
class Player
  def initialize(name)
    @name = name
    @pieces = []
    @possible = []
  end

  def update_pieces(piece)
    @pieces << piece
  end
end
