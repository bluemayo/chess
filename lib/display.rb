# frozen_string_literal: true

# This Module will contain methods to display needed messages to the terminal
module Display
  def display_no_moves
    puts 'Selected piece has no available moves!'
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

  def display_possible(possible)
    print 'Possible moves with selected piece: '
    possible.each do |move|
      row = move[0].to_s
      column = move[1] - 1 + 'a'.ord
      print ' | '
      print column.chr + row
    end
    print ' |'
    puts ''
  end
end
