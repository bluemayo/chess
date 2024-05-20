# frozen_string_literal: true

require_relative 'game'
require_relative 'board'
require_relative 'pieces'

my_game = Game.new
my_game.play
# my_board = Board.new
# my_board.populate_board
# my_board[[4, 1]] = Pieces::Bishop.new([4, 1], :white, my_board)
# my_board[[8, 2]] = nil
# my_board[[8, 3]] = nil
# my_board[[8, 4]] = Pieces::Bishop.new([8, 4], :black, my_board)
# my_board[[7, 4]] = nil
# # my_board[[7, 3]] = nil
# my_board[[7, 2]] = nil
# my_board.display
# puts my_board.checkmate?(:black)
# puts my_game.instance_variable_get(:@player1).instance_variable_get(:@pieces)
