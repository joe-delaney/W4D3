require_relative 'stepable.rb'

class King < Piece
  include Stepable

  def initialize(color, board, pos)
    super
    @symbol = "♔"
  end 

  def to_s 
    @symbol
  end

  private
  def move_diffs
    [[0,1],[1,0],[0,-1],[-1,0],[1,1],[1,-1],[-1,1],[-1,-1]]
  end
end
