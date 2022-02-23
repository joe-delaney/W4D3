require_relative 'display.rb'
require_relative 'human_player.rb'

class Game 

  attr_reader :board, :display, :players, :current_player

  def initialize
    @board = Board.new 
    @display = Display.new(@board)
    @players = [HumanPlayer.new(:white, @display), HumanPlayer.new(:black, @display)]
    @current_player = @players[0]
  end

  def play 
    until game_over?
      system("clear")
      display.render 
      notify_players
      begin
        player_move = current_player.make_move(board)
        start_pos, end_pos = player_move
        board.move_piece(start_pos, end_pos)
      rescue
        retry
      end
      swap_turn!
    end
    print "Checkmate! #{players[1].color} wins!!"
  end

  private
  def notify_players
    puts "#{current_player.color}! It is your turn!"
  end

  def swap_turn!
    if current_player == players[0]
      @current_player = players[1]
    else
      @current_player = players[0]
    end
  end

  def game_over?
    board.checkmate?(:white) || board.checkmate?(:black)
  end
end

g = Game.new 
g.play