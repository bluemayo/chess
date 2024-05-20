# frozen_string_literal: true

require_relative 'display'
require_relative 'board'
require_relative 'player'
require_relative 'serializable'

# Defines game logics
class Game
  attr_reader :player1, :player2, :board
  attr_accessor :current_player

  include Display
  include Serializable

  def initialize
    @player1 = Player.new(:white)
    @player2 = Player.new(:black)
    @board = Board.new
    board.populate_board
    @current_player = @player1
    @saved = false
  end

  def swap_player!
    self.current_player = current_player == player1 ? player2 : player1
  end

  def play
    game_loop until game_won?
  end

  def game_loop # rubocop: disable Metrics/AbcSize
    display_board(board.instance_variable_get(:@board))
    puts "#{current_player.color}'s turn"
    puts "#{current_player.color} is in check." if board.in_check?(current_player.color)
    current_position = player_select
    if current_position == 'save'
      save_game
      return
    end
    board.move(current_position, player_move(current_position))
    swap_player!
  end

  def game_won?
    if board.checkmate?(current_player.color)
      swap_player!
      puts "#{current_player.color} Won!"
      return true
    elsif @saved
      return true
    end
    false
  end

  def player_select
    position = nil
    loop do
      print 'Select Piece: '
      position = current_player.choose_position
      break if position == 'save'
      break if valid_select?(board[position])
    end
    position
  end

  def player_move(current_position)
    new_position = nil
    loop do
      print 'Move to: '
      new_position = current_player.choose_position
      break if board[current_position].valid_moves.include?(new_position)

      puts 'new position not in possible moves'
    end
    new_position
  end

  def valid_select?(piece)
    if piece.nil?
      display_no_piece
    elsif piece.color != current_player.color
      display_not_owned
    elsif piece.valid_moves.empty?
      display_no_moves
    else
      return true
    end
    false
  end

  def save_game
    @saved = true
    save_game_data(serialize)
  end

  def load_game(file)
    print "Detected a save file, would you like to continue? ('y' for yes):  "
    return unless gets.chomp.downcase == 'y'

    game_hash = unserialize(file)
    @board = game_hash[:@board]
    @player1 = game_hash[:@player1]
    @player2 = game_hash[:@player2]
    @current_player = game_hash[:@current_player]
    @saved = false
    File.delete('save_data/game_data.yml')
  end
end
