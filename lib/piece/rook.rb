# frozen-string-literal: true

require_relative 'piece'
require_relative 'moveable_piece'
require_relative 'moveset/horizontal_sliding_movement'
require_relative 'moveset/vertical_sliding_movement'

# a rook piece
class Rook < MoveablePiece
  include HorizontalSlidingMovement
  include VerticalSlidingMovement

  SYMBOL = 'R'

  def initialize(is_white_player)
    super(is_white_player, SYMBOL)
  end

  def paths(start_node, board)
    valid_vertical_nodes(start_node, board) + valid_horizontal_nodes(start_node, board)
  end

  private

  def valid_vertical_nodes(start_node, board)
    trim_friendly_endpoint(vertical_nodes(board, start_node, 1), start_node) +
      trim_friendly_endpoint(vertical_nodes(board, start_node, -1), start_node)
  end

  def valid_horizontal_nodes(start_node, board)
    trim_friendly_endpoint(horizontal_nodes(board, start_node, 1), start_node) +
      trim_friendly_endpoint(horizontal_nodes(board, start_node, -1), start_node)
  end
end
