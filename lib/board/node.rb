# frozen-string-literal: true

require_relative 'grid_coordinates'

# an abstract class for holding a node
# Nodes cannot exist without a grid
class Node
  # variables:
  # id: a unique id of the node that includes the column as a letter name and the row as a number (eg h8)
  # piece (a reference to the chess piece this node holds)
  PADDING = 2
  SIZE = ((PADDING * 2) + 1)

  attr_reader :row, :column, :id, :piece

  def initialize(row, column)
    @row = row
    @column = column
    @id = GridCoordinates.row_column_to_node_id(row, column)
    @piece = nil
  end

  # returns true if this node is occuppied by a piece with the same player as other_node's piece
  # Returns false if piece belongs to a different player or piece is nil
  def same_player?(other_node)
    return piece.player == other_node.piece.player if full? && other_node.full?

    false
  end

  def to_s
    return "#{Node.left_border} #{Node.right_border}" if @piece.nil?

    str = '|'
    # the '|' count as part of the size
    str += ' ' * (Node::PADDING - 2)
    str += @piece.to_s
    str += '|'
    str
  end

  # returns a string for a top or bottom horizontal border
  def self.horizontal_border
    str = '+'
    # the 2 '+' count as part of the size
    str += '-' * (Node::SIZE - 2)
    str += '+'
    str
  end

  def self.left_border
    str = '|'
    # the '|' count as part of the size
    str += ' ' * (Node::PADDING - 1)
    str
  end

  def self.right_border
    # the '|' count as part of the size
    str = ' ' * (Node::PADDING - 1)
    str += '|'
    str
  end

  # methods:
  # full?
  # Returns true if this node is occuppied by a piece
  def full?
    !@piece.nil?
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
    @piece = chess_piece
    chess_piece.has_moved = true
    previous_piece
  end

  # Removes the piece from this node
  def remove_piece
    @piece = nil
  end
end
