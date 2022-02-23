require_relative 'cursor.rb'
require_relative 'board.rb'
require 'colorize'
require 'colorized_string'

class Display

  attr_reader :board, :cursor

  def initialize(board)
    @board = board 
    @cursor = Cursor.new([0,0], board)
  end

  def render
    rows_to_s = []
    (0...board.length).each do |row_idx|
      new_row = []
      (0...board.length).each do |col_idx|
        pos = [row_idx, col_idx]
        color = board[pos].color
        background_color = get_background_color(row_idx, col_idx)
        new_row << " ".colorize(:color => :red, :background => background_color)
        new_row << board[pos].to_s.colorize(:color => color, :background => background_color)
        new_row << " ".colorize(:color => :red, :background => background_color)
      end
      rows_to_s << new_row
    end

    rows_to_s.each do |ele|
      puts ele.join('')
    end
  end

  def get_background_color(row_idx, col_idx)
    pos = [row_idx, col_idx]
    if pos == cursor.cursor_pos
      cursor.selected ? :green : :yellow
    elsif (row_idx + col_idx) % 2 == 0
      :red
    else
      :light_blue
    end
  end

  def play
    until cursor.cursor_pos == [7,7]
      system("clear")
      render
      cursor.get_input
    end
  end
end

b = Board.new
d = Display.new(b)
d.play

# s = " R Q K H P"
# puts s.colorize(:color => :light_blue, :background => :red) 