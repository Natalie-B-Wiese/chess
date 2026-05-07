# frozen-string-literal: true

# An abstract class for a single chess piece
class Piece
  # variables:
  # player: a reference to player they belong to (white player or black player)
  # board: a reference to the board this piece belongs to
  # node: a reference to the tile this piece currently sits on

  attr_reader :player
  attr_accessor :has_moved

  WHITE = "\e[47m"
  BLACK = "\e[100m"
  RESET = "\e[49m"

  def initialize(player, board, symbol)
    @player = player
    @board = board
    @symbol = symbol
    @color = player.is_white ? WHITE : BLACK
    @has_moved = false
  end

  # methods:
  # #to_s returns the piece's unique symbol
  def to_s
    "#{@color} #{@symbol} #{RESET}"
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

  # Removes the last node from path_array if the last nodes's piece belongs to the same player as this piece
  # Note: it modifies the original array
  def trim_friendly_endpoint(path_array, start_node)
    return path_array if path_array.empty?

    # remove last node if it is occuppied by same player
    path_array.pop if path_array.last.same_player?(start_node)

    path_array
  end
end
