require_relative 'slideable.rb'

class Rook < Piece
  include Slideable 

  def initialize(color, board, pos)
    super
    @symbol = :R
  end 

  def to_s 
    @symbol
  end

  private
  def move_dirs
    horizontal_dirs
  end
end