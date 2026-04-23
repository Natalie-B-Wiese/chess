# frozen-string-literal: true

# holds a bunch of nodes
class Grid
  # variables:
  # WIDTH (int)
  # HEIGHT (int)
  # nodes: 2D array of Node objects

  # methods:
  # #node_at_position(x, y, x_offset=0, y_offset=0)
  # return nil if x or y is negative
  # return nil if y+y_offset>=HEIGHT
  # return nil if x+x_offset>=WIDTH
  # returns nodes[y+y_offset][x+x_offset]

  # node_by_id(id)
  # Select the node with the specified id from nodes array
end
