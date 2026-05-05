# frozen-string-literal: true

# includes node array getter methods for a piece that slides on the board (in other words not the knight)
module SlidingMovement
  # returns true if the node is non-nil and empty
  def node_valid_to_move_to?(node)
    return false if node.nil? || node.full?

    true
  end

  # return an array of nodes that can be moved to at the offset
  # the last node returned may not be valid because it could be occuppied by same player
  # Last node is however guaranteed to not be nil
  def path_in_direction(board, start_node, x_direction, y_direction, distance = 100)
    path_array = []
    row = start_node.row
    column = start_node.column

    (0...distance).each do
      row += y_direction
      column += x_direction
      node = board.node_at_row_column(row, column)

      path_array.push(node) unless node.nil?
      return path_array unless node_valid_to_move_to?(node)
    end

    path_array
  end
end
