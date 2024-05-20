# frozen_string_literal: true

require_relative 'display'

# This class defines a player in a chess game
class Player
  include Display

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def choose_position
    to_row_and_column(check_position(gets.chomp))
  end

  private

  def check_position(file_and_rank)
    return [0, 0] unless file_and_rank.length == 2

    file_and_rank.split('').reverse
  end

  def to_row_and_column(array)
    array[0] = array[0].to_i
    return [0, 0] unless in_range?(array[0])

    array[1] = array[1].downcase.ord - 'a'.ord + 1
    return [0, 0] unless in_range?(array[1])

    array
  end

  def in_range?(position)
    return false if position < 1 || position > 8

    true
  end

  def owned?(position)
    @pieces.each do |piece|
      return true if piece.instance_variable_get(:@position) == position
    end
    false
  end
end
