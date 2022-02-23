require_relative 'stepable.rb'

class Knight < Piece
  include Stepable

  def initialize(color, board, pos)
    super
    @symbol = :H
  end 

  def to_s 
    @symbol
  end

  private
  def move_diffs
    [[2,-1],[2,1],[1,2],[-1,2],[-2,1],[-2,-1],[1,-2],[-1,-2]]
  end
end
