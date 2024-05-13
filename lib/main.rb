# frozen_string_literal: true

require_relative 'game'

my_game = Game.new
my_game.play
p my_game.instance_variable_get(:@player1).instance_variable_get(:@pieces)
