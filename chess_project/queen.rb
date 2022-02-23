class Queen < Piece
  include Slideable 

  def initialize(color, board, pos)
    super
    @symbol = :Q
  end 

  def to_s 
    @symbol
  end

  private
  def move_dirs
    horizontal_dirs + diagonal_dirs
  end
end