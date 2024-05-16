# frozen_string_literal: true

# This Module will contain methods to display needed messages to the terminal
module Display
  def display_invalid
    puts 'Invalid Move!'
  end

  def display_not_owned
    puts 'Thats not your piece!'
  end

  def display_board(board)
    puts '+---+---+---+---+---+---+---+---+'
    (1..8).each do |row|
      print '| '
      (1..8).each do |column|
        display_piece(board[9 - row][column])
        print ' | '
      end
      print "\n"
      puts '+---+---+---+---+---+---+---+---+'
    end
  end

  def display_piece(piece)
    print piece
    print ' ' if piece.nil?
  end
end
