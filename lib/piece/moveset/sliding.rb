# frozen-string-literal: true

# includes node array getter methods for a piece that slides on the board (in other words not the knight)
module Sliding
  # returns true if the node is non-nil and empty
  def node_valid_to_move_to?(node)
    return false if node.nil? || node.full?

    true
  end

  # return an array of nodes that can be moved to vertically
  # the last node returned may not be valid because it could be occuppied by same player
  # Last node is however guaranteed to not be nil
  # direction should be either 1 or -1
  def vertical_nodes(board, start_node, direction, distance = 100)
    diagonal_nodes(board, start_node, 0, direction, distance)
  end

  # return an array of nodes that can be moved to horizontally
  # the last node returned may not be valid because it could be occuppied by same player
  # Last node is however guaranteed to not be nil
  # direction should be either 1 or -1
  def horizontal_nodes(board, start_node, direction, distance = 100)
    diagonal_nodes(board, start_node, direction, 0, distance)
  end

  # return an array of nodes that can be moved to diagonally
  # the last node returned may not be valid because it could be occuppied by same player
  # Last node is however guaranteed to not be nil
  def diagonal_nodes(board, start_node, x_direction, y_direction, distance = 100)
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
