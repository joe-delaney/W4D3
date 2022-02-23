class Pawn < Piece

  def initialize(color, board, pos)
    super
    @symbol = "♙"
  end 

  def to_s 
    @symbol
  end

  #This will return the possible moves for the piece that called it
  def moves
    possible_moves = []

    #See if the pawn can move forward 1 or 2 spaces and if so add the move
    #to possible moves. 
    new_row = pos[0]
    (1..forward_steps).each do |i|
      new_row = new_row + forward_dir
      new_pos = [new_row, pos[1]]
      #Check if stepping forward is a valid move. Also check to see if the first
      #step was valid, if not, we can ignore the second step.
      if valid?(new_pos) && !(possible_moves.length == 0 && i == 2)
        possible_moves << new_pos 
      end
    end

    #Get the possible attack positions and add them if they are valid attacks
    possible_attacks = side_attacks(pos)
    possible_attacks.each do |attack_pos|
      possible_moves << attack_pos if valid_attack?(attack_pos)
    end
    possible_moves
  end

  private 
  #This checks if the position passed in is a valid move. It is a valid move
  #if it is within the boundaries and if its a null piece. 
  def valid?(pos)
    row, col = pos 
    row >= 0 && col >= 0 && row < board.length && col < board.length && board[pos].is_a?(NullPiece)
  end

  #This checks if the position passed in is a valid attacks. It is a valid 
  #attack if it is within boundaries and it is the opposite color piece.
  def valid_attack?(pos)
    row, col = pos 
    row >= 0 && col >= 0 && row < board.length && col < board.length && board[pos].color != color && !board[pos].is_a?(NullPiece)
  end

  #Determines which direction the pawn has to move based on its color
  def forward_dir
    if color == :black 
      return 1
    else
      return -1
    end
  end

  #Determines the number of steps a pawn can move (2 if at start row 1 if not)
  def forward_steps
    at_start_row? ? 2 : 1
  end

  #Returns whether or not the current piece is at the start row
  def at_start_row?
    return true if color == :white && pos[0] == 6
    return true if color == :black && pos[0] == 1
    return false
  end

  #Returns an array with the possible diagonal attacks for the current piece
  def side_attacks(pos)
    row, col = pos
    if color == :white
      possible_attack_1 = [row-1, col-1]
      possible_attack_2 = [row-1, col+1]
    else
      possible_attack_1 = [row+1, col-1]
      possible_attack_2 = [row+1, col+1]
    end
    [possible_attack_1, possible_attack_2]
  end

end