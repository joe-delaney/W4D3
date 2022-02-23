module Slideable 
  #Represents one step in each direction horizontally and diagonally
  HORIZONTAL_DIRS = [[0,1], [1,0], [0,-1],[-1,0]]
  DIAGONAL_DIRS = [[1,1],[1,-1],[-1,1],[-1,-1]] 

  def horizontal_dirs
    HORIZONTAL_DIRS
  end

  def diagonal_dirs 
    DIAGONAL_DIRS
  end

  #This will return the possible moves for the piece that called it
  def moves
    possible_moves = []
    #Call move_dirs to get the possible directions this piece can move in
    #The kind of piece calling moves will determine the valid directions
    directions = move_dirs

    #Go through each direction and pass it to helper method
    #helper method will return an array of possible moves in that direction
    directions.each do |direction|
      dx = direction[0]
      dy = direction[1]
      possible_moves += grow_unblocked_moves_in_dr(dx, dy)
    end
    possible_moves
  end

  private
  def move_dirs
    #Dummy method, should get overwitten by subclass
    horizontal_dirs + diagonal_dirs
  end

  #This will return the possible moves a piece can make in one direction
  #Slideable pieces are able to move as far as they want in one direction
  #as long as they remain in the boundaries of the board (0..7) and are not
  #blocked by another piece of its color
  def grow_unblocked_moves_in_dr(dx, dy)
    start_pos = pos 
    unblocked_moves = []
    new_row = start_pos[0] + dx
    new_col = start_pos[1] + dy
    new_pos = [new_row, new_col ]
    while (new_row >= 0 && new_col >= 0 && new_row < board.length && 
      new_col < board.length && (board[new_pos].is_a?(NullPiece) || 
      board[new_pos].color != color))
      unblocked_moves << new_pos
      if board[new_pos].color != color && !board[new_pos].is_a?(NullPiece)
        #This if exists so that we only add a position with an opposite
        #color piece once and exit the loop. Without this, we would be able
        #to go through a piece of the opposite color to another space.
        new_row = -1
        new_col = -1
        new_pos = [new_row, new_col]
      else
        new_row = new_row + dx
        new_col = new_col + dy
        new_pos = [new_row, new_col]
      end
    end
    unblocked_moves
  end
end 