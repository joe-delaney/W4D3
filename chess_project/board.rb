require_relative 'pieces.rb'

class Board 
  BOARD_SIZE = 8
  
  attr_accessor :rows

  #initialize an 8x8 board and set each space to a null piece
  #call helper method fill board to place pieces
  def initialize(fill = true)
    @rows = Array.new(BOARD_SIZE){Array.new(BOARD_SIZE, NullPiece.instance)}
    fill_board if fill
  end

  def deep_dup
    #Create a new, empty board
    new_board = Board.new(false)

    #Get array of all pieces on the board
    pieces = get_pieces

    #Add new pieces (copies of old pieces) to our new board
    pieces.each do |piece|
      color = piece.color
      row = piece.pos[0]
      col = piece.pos[1]
      pos = [row,col]
      piece.class.new(color, new_board, pos)
    end

    #return new board
    new_board
  end

  #called when board is initialized to place pieces
  def fill_board 
    #for each color, fill the pawn row and the back row using helper methods
    [:white, :black].each do |color|
      fill_back_rows(color)
      fill_pawn_rows(color)
    end
  end

  #helper method to fill the pawn rows for both colors
  def fill_pawn_rows(color)
    #if color is white, we should fill pawns at row 6 otherwise at row 1
    color == :white ? i = 6 : i = 1
    (0...BOARD_SIZE).each do |j|
      Pawn.new(color, self, [i,j])
    end
  end

  #helper method to fill the back rows for both colors
  def fill_back_rows(color)
    #We can use this to place pieces in this order in the back row
    pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

    #if color is white, we should fill back row 7 otherwise back row 0
    color == :white ? i = 7 : i = 0
    pieces.each_with_index do |piece, j|
      piece.new(color, self, [i,j])
    end
  end

  def [](pos)
    row,col = pos 
    @rows[row][col]
  end

  def []=(pos,val)
    row,col = pos 
    @rows[row][col] = val
  end

  def length 
    BOARD_SIZE
  end

  #Takes in a start pos and end pos and moves piece if valid
  def move_piece(start_pos, end_pos)
    #raise error if start is null because we can't move from an empty spot
    raise "Invalid Start Position" if self[start_pos].is_a?(NullPiece)

    #raise error if end pos is not empty and its filled by the same color piece
    #it is a valid attack if it is filled by an opposite color piece
    if !self[end_pos].is_a?(NullPiece) && self[end_pos].color == self[start_pos].color
      raise "Invalid End Position" 
    elsif !self[start_pos].valid_moves.include?(end_pos)
      raise "Invalid Move, that puts us into check"
    else
     move_piece!(start_pos, end_pos)
    end
  end

  def move_piece!(start_pos, end_pos)
     #Save the current piece at the start pos
      moved = self[start_pos]

      #move the current piece to end pos and update the piece's position variable
      self[end_pos] = moved
      self[end_pos].pos = end_pos

      #Empty the start pos
      self[start_pos] = NullPiece.instance
  end

  #This is called when a new piece is made to place itself on the board
  def add_piece(piece, pos)
    self[pos] = piece
  end

  #Determines whether a color is in check or not
  def in_check?(color)
    king_pos = find_king(color)
    color == :white ? opposing_color = :black : opposing_color = :white 
    opponent_moves = get_all_moves(opposing_color)
    opponent_moves.include?(king_pos)
  end

  #Determines if a color is in checkmate by going through each of the 
  #color's pieces and seeing if any have a valid move
  def checkmate?(color)
    if in_check?(color)
      (0...self.length).each do |row_idx|
        (0...self.length).each do |col_idx|
          pos = [row_idx, col_idx]
          if self[pos].color == color && self[pos].valid_moves.length > 0
            return false 
          end
        end
      end
      return true
    end
  end

  #Finds the position of the king that is the color of what is passed in
  def find_king(color)
    (0...self.length).each do |row_idx|
      (0...self.length).each do |col_idx|
        current_pos = [row_idx, col_idx]
        if self[current_pos].is_a?(King) && self[current_pos].color == color
          return current_pos
        end
      end
    end
  end

  #Get all possible moves for a certain player (color)
  def get_all_moves(color)
    all_moves = []
    (0...self.length).each do |row_idx|
      (0...self.length).each do |col_idx|
        current_pos = [row_idx, col_idx]
        if self[current_pos].color == color
          all_moves += self[current_pos].moves
        end
      end
    end
    all_moves
  end

  #This returns an array of all of the pieces on the board
  def get_pieces
    pieces = []
    (0...self.length).each do |row_idx|
      (0...self.length).each do |col_idx|
        current_pos = [row_idx, col_idx]
        pieces << self[current_pos] if !self[current_pos].is_a?(NullPiece)
      end
    end
    pieces
  end
    
 end

# b = Board.new
# p '-----'
# b.print_board

# p b[[6,1]].moves
# b.move_piece([1,4])



