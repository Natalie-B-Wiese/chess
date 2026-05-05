# frozen-string-literal: true

require_relative 'sliding_movement'

# Gets nodes along a horizontal path
module HorizontalSlidingMovement
  include SlidingMovement

  # return an array of nodes that can be moved to horizontally
  # the last node returned may not be valid because it could be occuppied by same player
  # Last node is however guaranteed to not be nil
  # direction should be either 1 or -1
  def horizontal_nodes(board, start_node, direction, distance = 100)
    path_in_direction(board, start_node, direction, 0, distance)
  end
end
