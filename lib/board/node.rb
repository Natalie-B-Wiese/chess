# frozen-string-literal: true

# an abstract class for holding a node
# Nodes cannot exist without a grid
class Node
  # variables:
  # id: a unique id of the node that includes the column as a letter name and the row as a number (eg h8)
  # piece (a reference to the chess piece this node holds)
  PADDING = 2
  SIZE = ((PADDING * 2) + 1)

  attr_reader :row, :column, :id, :piece

  def initialize(row, column, id)
    @row = row
    @column = column
    @id = id
    @piece = nil
  end

  def to_s
    return Node.left_border + ' ' + Node.right_border if @piece.nil?

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

  # Replaces the current @piece value with chess_piece
  # It returns the chess piece that was replaced (which could be nil)
  def replace_piece(chess_piece)
    previous_piece = @piece
    @piece = chess_piece
    previous_piece
  end

  # Removes the piece from this node
  def remove_piece
    @piece = nil
  end
end
