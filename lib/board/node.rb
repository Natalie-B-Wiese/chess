# frozen-string-literal: true

require_relative 'grid_coordinates'
require_relative '../save_load/fen'
require_relative '../piece/piece_conversion'

# an abstract class for holding a node
# Nodes cannot exist without a grid
class Node
  include Fen

  # variables:
  # id: a unique id of the node that includes the column as a letter name and the row as a number (eg h8)
  # piece (a reference to the chess piece this node holds)
  attr_reader :row, :column, :id, :piece

  def initialize(row, column)
    @row = row
    @column = column
    @id = GridCoordinates.row_column_to_node_id(row, column)
    @piece = nil
  end

  # returns the piece's fen if there is a piece (or passant). If there is no piece or passant, it returns nil
  # Example fen produced: R
  def as_fen
    if @piece.nil?
      nil
    else
      @piece.as_fen
    end
  end

  # loads the piece from the fen string (fen string should be a single letter representing the piece)
  def load_from_fen(fen_str)
    set_initial_piece(PieceConversion.from_fen(fen_str))
  end

  # sets the node link of the piece if the piece is a passant
  def setup_if_passant(board)
    return unless contains_passant?

    r = @row
    # white pawns move up, while black pawns move columns down
    if @piece.is_white
      r += 1
    else
      r -= 1
    end
    node_link = board.node_at_row_column(r, @column)
    @piece.setup_node_link(node_link)
  end

  # returns true if this node is occuppied by a piece with the same player as other_node's piece
  # Returns false if piece belongs to a different player or piece is nil
  def same_player?(other_node)
    return piece.same_player?(other_node.piece) if !@piece.nil? && !other_node.piece.nil?

    false
  end

  def to_s
    @id
  end

  # methods:
  # full?
  # Returns true if this node is occuppied by a piece (excludes passant pieces)
  def full?
    !@piece.nil? && !contains_passant?
  end

  def contains_passant?
    @piece.instance_of?(PawnPassant)
  end

  # places the chess piece in this node but does not set has_moved on the chess piece
  def set_initial_piece(chess_piece)
    @piece = chess_piece
  end

  # Replaces the current @piece value with chess_piece
  # It returns the chess piece that was replaced (which could be nil)
  # Sets has_moved flag for the piece
  def replace_piece(chess_piece)
    previous_piece = @piece

    @piece.kill_linked_piece if contains_passant? && chess_piece.instance_of?(Pawn)

    @piece = chess_piece
    chess_piece.has_moved = true
    previous_piece
  end

  # Removes the piece from this node
  def remove_piece
    @piece = nil
  end

  # clears the en passant of the specified player
  def clear_en_passant_of_player(player)
    remove_piece if contains_passant? && @piece.is_white == player.is_white
  end
end
