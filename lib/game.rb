# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'display'

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
    init_pieces
  end

  def init_pieces
    8.times do |column|
      create_pieces(column)
    end
  end

  def play
    @board.move(@player1.choose_piece, @player1.move_to)
  end

  private

  def create_pieces(column)
    @player1.update_pieces(@board.create_pawn(1, column, :white))
    @player2.update_pieces(@board.create_pawn(6, column, :black))
    @player1.update_pieces(@board.create_non_pawn(0, column))
    @player2.update_pieces(@board.create_non_pawn(7, column))
  end

  def turn(player)
    @board.select_piece(player.choose_piece)
    @board.decide(verify_move(player.move_to))
  end

  def verify_move(move)
    move if @board.possible.include?(move)

    display_invalid
  end
end
