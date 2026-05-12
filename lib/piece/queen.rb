# frozen-string-literal: true

require_relative 'piece'
require_relative 'moveable_piece'

require_relative 'moveset/diagonal_sliding_movement'
require_relative 'moveset/horizontal_sliding_movement'
require_relative 'moveset/vertical_sliding_movement'

# a queen piece
class Queen < MoveablePiece
  include DiagonalSlidingMovement
  include HorizontalSlidingMovement
  include VerticalSlidingMovement

  def initialize(is_white_player)
    graphic = 'Q'
    super(is_white_player, graphic)
  end

  def paths(start_node, board)
    valid_diagonal_nodes(start_node,
                         board) + valid_vertical_nodes(start_node, board) + valid_horizontal_nodes(start_node, board)
  end

  private

  def valid_diagonal_nodes(start_node, board)
    trim_friendly_endpoint(up_right_nodes(board, start_node), start_node) +
      trim_friendly_endpoint(up_left_nodes(board, start_node), start_node) +
      trim_friendly_endpoint(down_left_nodes(board, start_node), start_node) +
      trim_friendly_endpoint(down_right_nodes(board, start_node), start_node)
  end

  def valid_vertical_nodes(start_node, board)
    trim_friendly_endpoint(vertical_nodes(board, start_node, 1), start_node) +
      trim_friendly_endpoint(vertical_nodes(board, start_node, -1), start_node)
  end

  def valid_horizontal_nodes(start_node, board)
    trim_friendly_endpoint(horizontal_nodes(board, start_node, 1), start_node) +
      trim_friendly_endpoint(horizontal_nodes(board, start_node, -1), start_node)
  end
end
