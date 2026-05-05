# frozen-string-literal: true

require_relative 'piece'

# a knight piece
class Knight < Piece
  def initialize(player, board)
    graphic = 'N'

    super(player, board, graphic)
  end

  def paths
    start_node = node
    move_nodes(start_node).reject do |n|
      n.nil? || n.same_player?(start_node)
    end
  end

  private

  # an array of nodes that this knight could possibly move to. Might include some nil nodes if they are out of bounds
  def move_nodes(start_node)
    row = start_node.row
    column = start_node.column

    [
      @board.node_at_row_column(row + 1, column + 2),
      @board.node_at_row_column(row - 1, column + 2),
      @board.node_at_row_column(row + 2, column + 1),
      @board.node_at_row_column(row - 2, column + 1),

      @board.node_at_row_column(row + 1, column - 2),
      @board.node_at_row_column(row - 1, column - 2),
      @board.node_at_row_column(row + 2, column - 1),
      @board.node_at_row_column(row - 2, column - 1)
    ]
  end
end
