# frozen-string-literal: true

require_relative 'piece'

# a knight piece
class Knight < Piece
  def initialize(is_white_player)
    graphic = 'N'

    super(is_white_player, graphic)
  end

  def paths(start_node, board)
    move_nodes(start_node, board).reject do |n|
      n.nil? || n.same_player?(start_node)
    end
  end

  private

  # an array of nodes that this knight could possibly move to. Might include some nil nodes if they are out of bounds
  def move_nodes(start_node, board)
    row = start_node.row
    column = start_node.column

    [
      board.node_at_row_column(row + 1, column + 2),
      board.node_at_row_column(row - 1, column + 2),
      board.node_at_row_column(row + 2, column + 1),
      board.node_at_row_column(row - 2, column + 1),

      board.node_at_row_column(row + 1, column - 2),
      board.node_at_row_column(row - 1, column - 2),
      board.node_at_row_column(row + 2, column - 1),
      board.node_at_row_column(row - 2, column - 1)
    ]
  end
end
