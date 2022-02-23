require_relative 'player.rb'

class HumanPlayer < Player

  def initialize(color, display)
    super
  end

  def make_move(board)
    puts "Make your move!"
    start_pos = nil
    end_pos = nil
    while end_pos.nil?
      temp = @display.cursor.get_input
      if !temp.nil? && start_pos.nil?
        start_pos = temp
        if board[start_pos].color != color 
          puts "Please select your own piece"
          # system('clear')
          # @display.cursor.toggle_selected
          # @display.render
          raise StandardError
        end
      elsif !temp.nil? && !start_pos.nil?
        end_pos = temp
      end
      system("clear")
      @display.render
    end
    [start_pos, end_pos]
  end
end