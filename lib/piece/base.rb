# frozen-string-literal: true

# An abstract class for a single chess piece
class Base
  # variables:
  # player: a reference to player they belong to (white player or black player)
  # board: a reference to the board this piece belongs to
  # node: a reference to the tile this piece currently sits on

  attr_reader :player

  def initialize(player, board)
    @player = player
    @board = board
  end

  # methods:
  # #to_s returns the piece's unique symbol
  def to_s
    raise NotImplementedError, 'This method must be implemented in a subclass'
  end

  # #same_player?(ChessPiece other)
  # Returns true if this piece and the other piece have the same player, false otherwise
  def same_player?(other)
    @player == other.player
  end

  # #valid_move?(Node node)
  # returns true if this piece can move to the specified node
  # The Node must be along this ChessPiece's valid move paths, otherwise this returns false
  # It cannot move to the Node if its path is blocked by a piece (unless this chess piece is a horse)
  # If node is occuppied by a piece that is the same_player? as this piece, it returns false
  # If node is occuppied by a piece that is not the same_player? as this piece, it returns true
  def valid_move?(node)
    raise NotImplementedError, 'This method must be implemented in a subclass'
  end

  # paths
  # Returns an array of all nodes that this piece could move to, based solely on this piece's move direction
  # Not all nodes it returns are a valid_move. It does not take into account if the node is occuppied
  def paths
    raise NotImplementedError, 'This method must be implemented in a subclass'
  end
end
