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
  include Display

  def initialize
    @player1 = Player.new(:white)
    @player2 = Player.new(:black)
    @board = Board.new
    init_pieces
  end

  def init_pieces
    (1..8).each do |column|
      create_pieces(column)
    end
  end

  def play
    turn(@player1, @player2)
    turn(@player2, @player1)
  end

  private

  def create_pieces(column)
    @player1.update_pieces(@board.create_non_pawn(6, 2))
    @player1.update_pieces(@board.create_pawn(2, column, 1))
    @player2.update_pieces(@board.create_pawn(7, column, -1))
    @player1.update_pieces(@board.create_non_pawn(1, column))
    @player2.update_pieces(@board.create_non_pawn(8, column))
  end

  def turn(player, opponent)
    @board.select_piece(player.choose_piece)
    opponent.delete_piece(@board.move(verify_move(player)))
  end

  def verify_move(player)
    move = player.move_to
    return move if @board.instance_variable_get(:@possible).include?(move)

    display_invalid
    verify_move(player)
  end
end
