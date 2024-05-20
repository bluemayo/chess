# frozen_string_literal: true

require_relative 'game'
require_relative 'board'
require_relative 'pieces'

my_game = Game.new

my_game.load_game(File.read('save_data/game_data.yml')) if File.exist?('save_data/game_data.yml')

my_game.play
