# frozen-string-literal: true

require_relative 'piece'
require_relative 'moveset/diagonal_sliding_movement'
require_relative 'moveset/horizontal_sliding_movement'
require_relative 'moveset/vertical_sliding_movement'

# a king piece
class King < Piece
  include DiagonalSlidingMovement
  include HorizontalSlidingMovement
  include VerticalSlidingMovement

  DISTANCE = 1

  def initialize(player, board)
    graphic = 'K'
    super(player, board, graphic)
  end

  def paths
    valid_diagonal_nodes + valid_vertical_nodes + valid_horizontal_nodes
  end

  private

  def valid_diagonal_nodes
    start_node = node
    trim_friendly_endpoint(up_right_nodes(@board, start_node, DISTANCE), start_node) +
      trim_friendly_endpoint(up_left_nodes(@board, start_node, DISTANCE), start_node) +
      trim_friendly_endpoint(down_left_nodes(@board, start_node, DISTANCE), start_node) +
      trim_friendly_endpoint(down_right_nodes(@board, start_node, DISTANCE), start_node)
  end

  def valid_vertical_nodes
    start_node = node
    trim_friendly_endpoint(vertical_nodes(@board, start_node, 1, DISTANCE), start_node) +
      trim_friendly_endpoint(vertical_nodes(@board, start_node, -1, DISTANCE), start_node)
  end

  def valid_horizontal_nodes
    start_node = node
    trim_friendly_endpoint(horizontal_nodes(@board, start_node, 1, DISTANCE), start_node) +
      trim_friendly_endpoint(horizontal_nodes(@board, start_node, -1, DISTANCE), start_node)
  end
end
