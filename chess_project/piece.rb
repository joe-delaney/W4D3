class Piece 

  attr_reader :color, :board, :pos
  def initialize (color, board, pos)
    @color = color 
    @board = board 
    @pos = pos
    #This adds this piece instance to the board at its pos
    board.add_piece(self, pos)
  end 

  def to_s 
    return :P
  end

  def pos=(other_pos)
    @pos = other_pos
  end

  def color=(new_color)
    @color = new_color
  end

  def empty? 
    return board[pos].is_a?(NullPiece) 
  end 

  def moves 
    #Gets overriden by subclasses
  end

  def valid_moves
    all_moves = moves 
    all_moves.select {|move| !move_into_check?(move) }
  end

  #Return true if a player is in check after a move from pos to end_pos is made
  def move_into_check?(end_pos)
    #Duplicate the current board
    new_board = board.deep_dup 
    #Make the move on the duplicate board
    new_board.move_piece!(pos, end_pos)
    #Return whether or not the new_board is in check
    new_board.in_check?(color)
  end

end 