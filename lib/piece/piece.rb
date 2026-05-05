# frozen-string-literal: true

# An abstract class for a single chess piece
class Piece
  # variables:
  # player: a reference to player they belong to (white player or black player)
  # board: a reference to the board this piece belongs to
  # node: a reference to the tile this piece currently sits on

  attr_reader :player

  WHITE = "\e[47m"
  BLACK = "\e[100m"
  RESET = "\e[49m"

  def initialize(player, board, symbol)
    @player = player
    @board = board
    @symbol = symbol
    @color = player.is_white ? WHITE : BLACK
  end

  # methods:
  # #to_s returns the piece's unique symbol
  def to_s
    "#{@color} #{@symbol} #{RESET}"
  end

  # #same_player?(ChessPiece other)
  # Returns true if this piece and the other piece have the same player, false otherwise
  def same_player?(other_piece)
    @player == other_piece.player
  end

  # the node this piece is currently in
  def node
    @board.node_by_piece(self)
  end

  # #valid_move?(Node node)
  # returns true if this piece can move to the specified node
  def valid_move?(goal_node)
    paths.include?(goal_node)
  end

  # paths
  # Returns an array of all valid nodes that this piece can move to
  def paths
    raise NotImplementedError, 'This method must be implemented in a subclass'
  end
end
