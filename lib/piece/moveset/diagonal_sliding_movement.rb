# frozen-string-literal: true

require_relative 'sliding_movement'

# gets nodes along a diagonal path
module DiagonalSlidingMovement
  include SlidingMovement

  # all these methods return an array of nodes that can be moved to diagonally
  # the last node returned may not be valid because it could be occuppied by same player
  # Last node is however guaranteed to not be nil
  def up_right_nodes(board, start_node, distance = 100)
    path_in_direction(board, start_node, 1, 1, distance)
  end

  def up_left_nodes(board, start_node, distance = 100)
    path_in_direction(board, start_node, -1, 1, distance)
  end

  def down_left_nodes(board, start_node, distance = 100)
    path_in_direction(board, start_node, -1, -1, distance)
  end

  def down_right_nodes(board, start_node, distance = 100)
    path_in_direction(board, start_node, 1, -1, distance)
  end
end
