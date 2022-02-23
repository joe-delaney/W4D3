require_relative 'piece.rb'
require 'singleton'

class NullPiece < Piece
  include Singleton

  attr_reader :color

  def initialize
    @symbol = " "
    @color = :none
  end 

  def to_s 
    @symbol
  end

  def moves
    #This does nothing. It is a placeholder to allow for duck typing
  end
end
