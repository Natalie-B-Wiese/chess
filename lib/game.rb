# frozen-string-literal: true

require_relative 'board/grid'

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
    keep_playing = true

    until keep_playing == false
      @board.draw_board
      print_current_player

      keep_playing = play_round

      switch_player
    end

    puts 'quitting...'
  end

  # plays a round
  # It returns false if quitting and true if it should continue playing
  def play_round
    move = start_and_end_node

    return false if move.nil?

    start_node, end_node = move
    selected_piece = start_node.piece

    # preform the move
    piece_killed = end_node.replace_piece(selected_piece)
    start_node.remove_piece

    print_move_result(@current_player, selected_piece, end_node, piece_killed)

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

  def print_move_result(player, selected_piece, end_node, piece_killed)
    str = "#{player.name}'s #{selected_piece.class} moved to #{end_node.id}"

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
      elsif Grid.valid_node_id?(answer)
        return answer
      end

      puts 'Invalid position!'
    end
  end

  def print_current_player
    puts "It is #{@current_player.name}'s turn"
  end
end
