# frozen_string_literal: true

require_relative 'display'
require_relative 'board'
require_relative 'player'

# Defines game logics
class Game
  attr_reader :player1, :player2, :board
  attr_accessor :current_player

  include Display

  def initialize
    @player1 = Player.new(:white)
    @player2 = Player.new(:black)
    @board = Board.new
    @current_player = @player1
  end

  def swap_player!
    self.current_player = current_player == player1 ? player2 : player1
  end

  def play
    game_loop until game_won?
  end

  def game_loop
    display_board(board.board)
    puts "#{current_player.color}'s turn"
    board.select_piece(player_select)
    board.move(player_move)
    swap_player!
  end

  def game_won?
    false
  end

  def player_select
    position = nil
    loop do
      print 'Select Piece: '
      position = current_player.choose_position
      break if valid_select?(board[position])
    end
    position
  end

  def player_move
    position = nil
    loop do
      print 'Move to: '
      position = current_player.choose_position
      break if board.selected.possible_moves.include?(position)

      puts 'new position not in possible moves'
    end
    position
  end

  def valid_select?(piece)
    if piece.nil?
      display_no_piece
    elsif piece.color != current_player.color
      display_not_owned
    elsif piece.possible_moves.empty?
      display_no_moves
    else
      return true
    end
    false
  end
end
