class Bishop < Piece
  include Slideable 

  def initialize(color, board, pos)
    super
    @symbol = :B
  end 

  def to_s 
    @symbol
  end

  private
  def move_dirs
    diagonal_dirs
  end
end