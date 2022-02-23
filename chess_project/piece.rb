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
end 