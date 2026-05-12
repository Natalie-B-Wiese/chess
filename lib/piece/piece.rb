# frozen-string-literal: true

require_relative '../terminal/terminal_colors'

# An abstract class for a single chess piece
class Piece
  attr_accessor :has_moved
  attr_reader :is_white

  def initialize(is_white_player, symbol)
    # @player = player
    # @board = board
    @symbol = symbol
    @is_white = is_white_player
    @color = is_white_player ? TerminalColors::WHITE : TerminalColors::BLACK
    @has_moved = false
  end

  def same_player?(other_piece)
    return false if other_piece.nil?

    @is_white == other_piece.is_white
  end

  # methods:
  # #to_s returns the piece's unique symbol
  def to_s
    "#{@color} #{@symbol} #{TerminalColors::RESET}"
  end

  # returns false
  def promotable?
    false
  end

  # #valid_move?(Node node)
  # returns true if this piece can move to the specified node
  def valid_move?(starting_node, goal_node, board)
    paths(starting_node, board).include?(goal_node)
  end

  # paths
  # Returns an array of all valid nodes that this piece can move to
  def paths(starting_node, board)
    raise NotImplementedError, 'This method must be implemented in a subclass'
  end

  # Removes the last node from path_array if the last nodes's piece belongs to the same player as this piece
  # Note: it modifies the original array
  def trim_friendly_endpoint(path_array, start_node)
    return path_array if path_array.empty?

    # remove last node if it is occuppied by same player
    path_array.pop if path_array.last.same_player?(start_node)

    path_array
  end
end
