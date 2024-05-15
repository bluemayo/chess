# frozen_string_literal: true

# This Module will contain methods to display needed messages to the terminal
module Display
  def display_invalid
    puts 'Invalid Move!'
  end

  def display_not_owned
    puts 'Thats not your piece!'
  end
end
