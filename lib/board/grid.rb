# frozen-string-literal: true

require_relative 'node'
require_relative 'grid_coordinates'
require_relative 'grid_settings'

# holds a bunch of nodes
class Grid
  # a 2D array (only accessed from Grid_Drawer)
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

  # returns an array of nodes that have a passant
  def nodes_with_en_passant
    @all_nodes.select(&:contains_passant?)
  end

  # returns an array of nodes that have pieces on them belonging to the specified color
  def nodes_with_is_white_value(is_white)
    nodes_with_pieces.select { |node| node.piece.is_white == is_white }
  end

  # returns an array of nodes that have a piece on them belonging to specified player
  def nodes_with_player_piece(player)
    nodes_with_is_white_value(player.is_white)
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
  def nodes_by_piece_type(piece_class)
    nodes_with_pieces.select do |node|
      node.piece.instance_of?(piece_class)
    end
  end

  def nodes_by_piece_type_and_is_white_value(piece_class, is_white)
    with_piece_type = nodes_by_piece_type(piece_class)
    with_player = nodes_with_is_white_value(is_white)

    with_piece_type.select do |node|
      with_player.include?(node)
    end
  end

  def nodes_by_piece_type_and_player(piece_class, player)
    nodes_by_piece_type_and_is_white_value(piece_class, player.is_white)
  end

  def node_reachable_by_is_white_value?(goal_node, is_white)
    nodes_with_is_white_value(is_white).each do |node|
      return true if node.piece.valid_move?(node, goal_node, self)
    end

    false
  end

  # returns true if the specified node can be reached by any of player's pieces in a single move
  def node_reachable_by_player?(goal_node, player)
    node_reachable_by_is_white_value?(goal_node, player.is_white)
  end

  # returns the node with the king that belongs to the specified player
  def player_king(player)
    nodes_by_piece_type_and_player(King, player)[0]
  end

  # returns true if the player's king is in check, false otherwise
  def player_king_in_check?(player)
    node_reachable_by_is_white_value?(player_king(player), !player.is_white)
  end

  # removes all en_passant 'pieces' that belong to the player
  def clear_all_en_passant_of_player(player)
    nodes_with_en_passant.each do |n|
      n.clear_en_passant_of_player(player)
    end
  end
end
