# frozen-string-literal: true

require_relative 'board/grid'
require_relative 'board/grid_drawer'
require_relative 'board/grid_coordinates'

# holds a game
class Game
  attr_reader :board

  # player1 is the white player, and player2 is the black player
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2

    @board = Grid.new

    @current_player = @player1
  end

  def play_game
    loop do
      GridDrawer.draw(@board)
      print_current_player

      keep_playing = play_round
      break unless keep_playing

      switch_player
    end

    puts 'quitting...'
  end

  # returns a hash where the keys are the players and the value is true if in check, and false otherwise
  def kings_in_check
    nodes_with_king = @board.node_by_piece_type(King)
    result = {}

    nodes_with_king.each do |node|
      player = node.piece.player
      opposing_player = opposite_player(player)

      result[player] = node_reachable_by_player?(node, opposing_player)
    end

    result
  end

  # preforms a valid move
  # returns nil if user quit game
  # If user did not quit, then it returns an array of info about the move
  def preform_valid_move
    loop do
      move = start_and_end_node
      return nil if move.nil?

      start_node, end_node = move
      selected_piece = start_node.piece
      previous_has_moved, piece_killed = simulate_move(start_node, end_node, selected_piece)

      return [start_node, end_node, selected_piece, piece_killed] unless kings_in_check[@current_player] == true

      puts 'Your King is in check with that move. Choose a different piece and move'

      undo_move(start_node, end_node, selected_piece, previous_has_moved, piece_killed)
    end
  end

  # preforms a move and keeps track of previous info in case move needs to undo
  # Returns [previous_has_moved, piece_killed]
  def simulate_move(start_node, end_node, selected_piece)
    previous_has_moved = selected_piece.has_moved

    # preform the move
    piece_killed = end_node.replace_piece(selected_piece)
    start_node.remove_piece

    # return the previous version of the move
    [previous_has_moved, piece_killed]
  end

  # Undoes a single move
  def undo_move(start_node, end_node, selected_piece, previous_has_moved, piece_killed)
    selected_piece.has_moved = previous_has_moved
    start_node.set_initial_piece(selected_piece)
    end_node.set_initial_piece(piece_killed)
  end

  # plays a round
  # It returns false if quitting (or game over) and returns true if it should continue playing
  def play_round
    move_info = preform_valid_move
    return false if move_info.nil?

    start_node, end_node, selected_piece, piece_killed = move_info
    print_move_result(start_node, end_node, selected_piece, piece_killed)

    opponent = opposite_player(@current_player)
    puts "#{opponent.name}'s King is now in check" if kings_in_check[opponent] == true

    return true unless piece_killed.instance_of?(King)

    puts 'Game over!'
    false
  end

  # switches the player
  def switch_player
    @current_player = opposite_player(@current_player)
  end

  # returns the opposite player to the passed in player
  def opposite_player(player)
    player == @player1 ? @player2 : @player1
  end

  # returns true if the specified node can be reached by any of player's pieces in a single move
  def node_reachable_by_player?(goal_node, player)
    @board.nodes_with_player_piece(player).each do |node|
      return true if node.piece.paths.include?(goal_node)
    end

    false
  end

  private

  # returns a valid start and end node as an array
  # index 0 is start node, and index 1 is end node.
  # returns nil if user quit game.
  def start_and_end_node
    ending_node = nil

    while ending_node.nil?
      starting_node = start_node
      return nil if starting_node.nil?

      ending_node = end_node(starting_node)
    end

    [starting_node, ending_node]
  end

  # print_move_result(start_node, end_node, selected_piece, piece_killed)
  def print_move_result(start_node, end_node, selected_piece, piece_killed)
    str = "#{@current_player.name}'s #{selected_piece.class} moved to #{end_node.id}"

    str += " and killed #{piece_killed.player.name}'s #{piece_killed.class}" unless piece_killed.nil?
    puts str
  end

  # returns a valid starting node
  # start_node always contains a chess piece that belongs to this player
  # Returns nil if user typed 'back'
  def start_node
    loop do
      response = player_node_id("Enter starting position (eg A1) or type 'back' to go back")

      return nil if response == 'back'

      node = @board.node_by_id(response)
      return node if valid_start_node?(node)
    end
  end

  # returns true if the node is valid, otherwise returns false
  def valid_start_node?(node)
    if node.nil?
      puts 'Invalid node'
    elsif !node.full?
      puts "There is no chess piece at #{node.id}"
    elsif node.piece.player == @current_player
      return true
    else
      puts "You cannot move the opposing player's piece!"
    end

    false
  end

  # returns a valid ending node
  # Returns nil if user typed 'back'
  def end_node(starting_node)
    loop do
      response = player_node_id("Enter ending position (eg A1) or type 'back' to go back")

      return nil if response == 'back'

      node = @board.node_by_id(response)
      return node if valid_end_node?(starting_node, node)
    end
  end

  # returns true if the node is valid, otherwise returns false
  def valid_end_node?(starting_node, goal_node)
    return true if !goal_node.nil? && starting_node.piece.valid_move?(goal_node)

    puts "Invalid move for #{starting_node.piece.class}"
    false
  end

  # returns a valid node_id or returns 'back' if user typed 'BACK' or 'back'
  def player_node_id(prompt)
    loop do
      puts prompt
      answer = gets.chomp.upcase

      if answer.downcase == 'back'
        return 'back'
      elsif GridCoordinates.valid_node_id?(answer)
        return answer
      end

      puts 'Invalid position!'
    end
  end

  def print_current_player
    puts "It is #{@current_player.name}'s turn"
  end
end
