# frozen-string-literal: true

# an abstract class for holding a node
# Nodes cannot exist without a grid
class Node
  # variables:
  # id: a unique id of the node that includes the column as a letter name and the row as a number (eg h8)
  # piece (a reference to the chess piece this node holds)
  PADDING = 2
  SIZE = ((PADDING * 2) + 1)

  def initialize(id)
    @id = id
    @piece = nil
  end

  def to_s
    content = @piece.nil? ? ' ' : @piece.to_s
    Node.left_border + content + Node.right_border
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

  # delete_piece
  # Removes the current chess piece from this node

  # place_piece(ChessPiece)
  # Places the specified chess piece in this node
end
