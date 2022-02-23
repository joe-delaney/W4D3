module Stepable 

  #This will return the possible moves for the piece that called it
  def moves 
    possible_moves = []
    
    #Call move_diffs to get the possible directions this piece can move in
    directions = move_diffs 

    #A stepable piece will only be able to move once in any of its directions
    #Check each direction and see if it results in a valid move
    #If so, add it to possible moves
    directions.each do |direction|
      new_row = pos[0]+direction[0]
      new_col = pos[1]+direction[1]
      new_p = [new_row, new_col]
      possible_moves << new_p if valid?(new_p)
    end
    possible_moves
  end 


  private 
  #Determines if a position can be moved into
  #Valid if row and col are within boundaries of board (0..7)
  #and if the space is either empty or occupied by the opposite color
  def valid?(pos)
    row, col = pos 
    (row >= 0 && col >= 0 && row < board.length && col < board.length && 
    (board[pos].is_a?(NullPiece) || board[pos].color != color))
  end

  def move_diffs 
    # OVERWRITTEN BY PIECE INSTANCE
  end 
end