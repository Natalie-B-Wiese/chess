# frozen-string-literal: true

require_relative '../terminal/terminal'
require_relative 'command'
require_relative '../board/grid_coordinates'

# parses and validates a move and returns an array of two node objects (start node and goal node)
# Move is validated
class EnterMoveCommand < Command
  # returns nil if command not recognized or move is invalid
  # Otherwise, it returns an array of validated node objects where index 0 is start_node and index 1 is goal node
  def self.execute(input, game)
    input = input.upcase

    # input must match format of: letter, number, space, letter, number
    if input.match(/^[A-Z][1-9]\s[A-Z][1-9]$/)
      parse_node_ids_from_input(input, game)
    else
      Terminal.print_error('Invalid command or move!')
      nil
    end
  end

  # parses a string input and returns two validated node objects for a move
  # Move is fully validated (except for detecting Kings in check)
  def self.parse_node_ids_from_input(input, game)
    node_ids = input.split(' ')
    start_node_id = node_ids[0]
    goal_node_id = node_ids[1]
    start_node = game.board.node_by_id(start_node_id)
    goal_node = game.board.node_by_id(goal_node_id)

    return nil unless valid_start_node?(start_node, start_node_id, game)
    return nil unless valid_end_node?(start_node, goal_node, goal_node_id, game.board)

    [start_node, goal_node]
  end

  # returns true if the node is valid, otherwise returns false
  # Prints an error message indicating what went wrong
  def self.valid_start_node?(node, node_id, game)
    if node.nil?
      Terminal.print_error("#{node_id} is out of bounds")
    elsif !node.full?
      Terminal.print_error("There is no chess piece at #{node}")
    elsif node.piece.same_player?(game.current_player)
      return true
    else
      Terminal.print_error("You cannot move the opposing player's piece!")
    end

    false
  end

  # returns true if the move is valid, otherwise returns false
  # Prints an error message indicating what went wrong
  def self.valid_end_node?(starting_node, goal_node, goal_node_id, board)
    if goal_node.nil?
      Terminal.print_error("#{goal_node_id} is out of bounds")
    elsif starting_node.piece.valid_move?(starting_node, goal_node, board)
      return true
    else
      Terminal.print_error("Invalid move for #{starting_node.piece.class}")
    end

    false
  end
end
