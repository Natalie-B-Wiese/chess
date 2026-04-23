# frozen-string-literal: true

# an abstract class for holding a node
# Nodes cannot exist without a grid
class Node
  # variables:
  # id: a unique id of the node that includes the column as a letter name and the row as a number (eg h8)
  # piece (a reference to the chess piece this node holds)

  # methods:
  # full?
  # Returns true if this node is occuppied by a piece

  # delete_piece
  # Removes the current chess piece from this node

  # place_piece(ChessPiece)
  # Places the specified chess piece in this node
end
