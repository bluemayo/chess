# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

# This class will define the flow of a chess game by calling methods from Board and Player classes
class Game
  # Initializing this class should start a new game by initializing other classes
  # TDL: 1) Methods to a) Start game
  #                    b) Loop through several methods to simulate players taking turns
  #                    c) Terminate loop once game has ended by winning or drawing
  #                    d) Serialize to save game
  def initialize
    @player1 = Player.new(:white)
    @player2 = Player.new(:black)
    @board = Board.new
    @board.init_pieces
    assign
  end

  def assign
    @board.instance_variable_get(:@board)[0].each { |piece| @player1.update_pieces(piece) }
    @board.instance_variable_get(:@board)[1].each { |piece| @player1.update_pieces(piece) }
    @board.instance_variable_get(:@board)[6].each { |piece| @player2.update_pieces(piece) }
    @board.instance_variable_get(:@board)[7].each { |piece| @player2.update_pieces(piece) }
  end
end
