# frozen-string-literal: true

require_relative 'board/grid'
require_relative 'board/grid_drawer'
require_relative 'board/grid_coordinates'

require_relative 'terminal/terminal'

require_relative 'user_input'

require_relative 'piece/piece_conversion'
require_relative 'piece/pawn_passant'

require_relative './player'

require_relative 'save_load/fen'

# holds a game
class Game
  include Fen
  attr_reader :board, :current_player

  def initialize
    # player 1 is white and player 2 is black
    @player1 = Player.new('Player 1', true)
    @player2 = Player.new('Player 2', false)

    @board = Grid.new

    @current_player = @player1
  end

  def as_fen
    raise NotImplementedError, "as_fen method must be implemented in class #{self.class.name}"
  end

  def load_from_fen(fen_str)
    raise NotImplementedError, "load_from_fen method is not yet implemented in class #{self.class.name}"
  end

  def play_game
    loop do
      @board.clear_all_en_passant_of_player(@current_player)

      GridDrawer.draw(@board)
      print_current_player

      keep_playing = play_round
      break unless keep_playing

      switch_player
    end

    puts 'quitting...'
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

      return [start_node, end_node, selected_piece, piece_killed] unless @board.player_king_in_check?(@current_player)

      Terminal.print_error('Your King is in check with that move. Choose a different piece and move')

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
    @board.clear_all_en_passant_of_player(@current_player)
    piece_killed.undo_kill_linked_piece if piece_killed.instance_of?(PawnPassant)
  end

  # plays a round
  # It returns false if quitting (or game over) and returns true if it should continue playing
  def play_round
    move_info = preform_valid_move
    return false if move_info.nil?

    start_node, end_node, selected_piece, piece_killed = move_info
    print_move_result(start_node, end_node, selected_piece, piece_killed)

    pawn_moved(start_node, end_node, selected_piece) if selected_piece.instance_of?(Pawn)

    opponent = opposite_player(@current_player)
    puts "#{opponent.name}'s King is now in check" if @board.player_king_in_check?(opponent) == true

    return true unless piece_killed.instance_of?(King)

    puts 'Game over!'
    false
  end

  # applies special logic when a pawn moves
  def pawn_moved(start_node, goal_node, pawn)
    promote(goal_node, pawn) if pawn.promotable?(goal_node)

    # if the pawn moved two squares, create a passant pawn on the square pawn jumped over
    create_passant_pawn(start_node, goal_node, pawn) if (goal_node.row - start_node.row).abs == 2
  end

  # creates a passant pawn between start_node and goal_node
  def create_passant_pawn(start_node, goal_node, pawn)
    mid_row = (goal_node.row + start_node.row) / 2
    mid_node = @board.node_at_row_column(mid_row, goal_node.column)
    passant = PawnPassant.new(pawn, goal_node)
    mid_node.set_initial_piece(passant)
  end

  # promotes the pawn at the specified node to a different piece
  def promote(node, pawn)
    promote_type = pawn.promote_type_input

    replacement_piece_class = PieceConversion.letter_to_piece_type(promote_type)
    puts "Pawn has been promoted to a #{replacement_piece_class.name}"

    replacement_piece = replacement_piece_class.new(pawn.player, @board)

    node.replace_piece(replacement_piece)
  end

  # switches the player
  def switch_player
    @current_player = opposite_player(@current_player)
  end

  # returns the opposite player to the passed in player
  def opposite_player(player)
    player == @player1 ? @player2 : @player1
  end

  private

  # returns a valid start and end node as an array
  # index 0 is start node, and index 1 is end node.
  # returns nil if user quit game.
  def start_and_end_node
    input = nil

    while input.nil?
      puts 'Enter move (eg A2 A3), enter a command, or type HELP'

      input = UserInput.gets_and_interpret(self)
      return nil if input == 'QUIT'
    end

    # if it made it here, then the input is the two nodes that are validated
    input
  end

  # print_move_result(start_node, end_node, selected_piece, piece_killed)
  def print_move_result(start_node, end_node, selected_piece, piece_killed)
    str = "#{@current_player.name}'s #{selected_piece.class} on #{start_node} moved to #{end_node}"

    player_who_died = opposite_player(@current_player)
    str += " and killed #{player_who_died.name}'s #{piece_killed.class}" unless piece_killed.nil?
    puts str
  end

  def print_current_player
    puts "It is #{@current_player.name}'s turn"
  end
end
