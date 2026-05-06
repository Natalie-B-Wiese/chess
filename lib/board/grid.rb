# frozen-string-literal: true

require_relative 'node'
require_relative 'grid_coordinates'
require_relative 'grid_settings'

# holds a bunch of nodes
class Grid
  # a 2 array
  attr_reader :nodes

  # creates a grid of nodes
  def initialize
    @nodes = []
    (0...GridSettings::HEIGHT).each do |r|
      @nodes.push([])
      (0...GridSettings::WIDTH).each do |c|
        node = Node.new(r, c)
        @nodes[r].push(node)
      end
    end

    @all_nodes = @nodes.flatten
  end

  # gets a node at a specified position. Returns nil if out of bounds
  def node_at_row_column(row, column)
    return nil if GridCoordinates.position_out_of_bounds?(column, row)

    @nodes[row][column]
  end

  def node_by_id(node_id)
    row, column = GridCoordinates.node_id_to_row_column(node_id)
    node_at_row_column(row, column)
  end

  # untested

  # returns an array of nodes that have a piece on them
  def nodes_with_pieces
    @all_nodes.select(&:full?)
  end

  # returns an array of nodes that have a piece on them belonging to specified player
  def nodes_with_player_piece(player)
    nodes_with_pieces.select { |node| node.piece.player == player }
  end

  # Returns the node that contains that specific chess piece object.
  # Note: Piece must match exactly. Two rooks of the same player are still different pieces
  def node_by_piece(piece)
    node_with_piece = nodes_with_pieces.select { |node| node.piece == piece }
    return nil if node_with_piece.empty?

    node_with_piece[0]
  end

  # returns an array of nodes that hold the specified piece type
  # could return an empty array if piece was not found
  def node_by_piece_type(piece_class)
    nodes_with_pieces.select do |node|
      node.piece.instance_of?(piece_class)
    end
  end
end
