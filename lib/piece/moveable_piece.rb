# frozen-string-literal: true

require_relative 'piece'

# An abstract class for a single chess piece that can move (ie not en passant pieces)
class MoveablePiece < Piece
  attr_accessor :has_moved

  attr_reader :goal_node, :start_node

  def initialize(is_white_player, symbol)
    super(is_white_player, symbol)
    @has_moved = false
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

  # simulates a move with this piece from start_node to goal piece
  # It keeps track of data
  def simulate_move(start_node, goal_node)
    puts 'Move simulated'
    @start_node = start_node
    @goal_node = goal_node

    @piece_killed = @goal_node.replace_piece(self)
    @start_node.remove_piece
  end

  # confirms the move of this piece
  def confirm_move(board)
    print_move_result

    @has_moved = true
    @start_node = nil
    @goal_node = nil
    @piece_killed = nil
  end

  # undoes the move that this piece just made
  def undo_move
    @start_node.set_initial_piece(self)
    @goal_node.set_initial_piece(@piece_killed)
    @piece_killed.undo_kill_linked_piece if @piece_killed.instance_of?(PawnPassant)
  end

  private

  def print_move_result
    str = "#{self.class.name} on #{@start_node} moved to #{@goal_node}"

    str += " and killed #{@piece_killed.class.name}" unless @piece_killed.nil?
    puts str
  end
end
