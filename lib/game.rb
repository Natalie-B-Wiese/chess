# frozen-string-literal: true

require_relative 'board/grid'
require_relative 'board/grid_drawer'
require_relative 'board/grid_coordinates'

require_relative 'terminal/terminal'

require_relative 'user_input'

require_relative 'piece/piece_conversion'
require_relative 'piece/pawn_passant'

require_relative './player'

require_relative 'save_load/serializable'

# holds a game
class Game
  include Serializable

  attr_reader :board, :rounds

  def initialize
    # player 1 is white and player 2 is black
    @player1 = Player.new('Player 1', true)
    @player2 = Player.new('Player 2', false)

    @board = Grid.new

    # the number of total moves that have been preformed
    # If each player does 1 move, then rounds will be 2
    @rounds = 0
  end

  # the current player based on the number of rounds completed
  def current_player
    @rounds.even? ? @player1 : @player2
  end

  def serialize
    obj = {}
    obj[:@board] = @board.as_fen
    obj[:@rounds] = @rounds

    @@serializer.dump obj
  end

  def unserialize(string)
    obj = @@serializer.parse(string, symbolize_names: true)
    @board.load_from_fen(obj[:@board])
    @rounds = obj[:@rounds]
  end

  def play_game
    loop do
      @board.clear_all_en_passant_of_player(current_player)

      GridDrawer.draw(@board)
      print_current_player

      # If current player is in checkmate, then quit the game
      in_check = @board.player_king_in_check?(current_player)
      if in_check
        in_checkmate = escape_check?(current_player) == false
        if in_checkmate
          Terminal.print_error("#{current_player.name} is in checkmate! Game over!")
          break
        else
          Terminal.print_error("#{current_player.name} is in check")
        end
      end

      keep_playing = play_round
      break unless keep_playing

      @rounds += 1
    end

    puts 'quitting...'
  end

  # preforms a valid move
  # returns nil if user quit game, otherwise returns true
  def preform_valid_move
    loop do
      move = start_and_end_node
      return nil if move.nil?

      start_node, end_node = move
      selected_piece = start_node.piece
      selected_piece.simulate_move(start_node, end_node)

      if @board.player_king_in_check?(current_player)
        Terminal.print_error('Your King is in check with that move. Choose a different move')
        selected_piece.undo_move
      else
        selected_piece.confirm_move(@board)
        return true
      end
    end
  end

  # plays a round
  # It returns false if quitting (or game over) and returns true if it should continue playing
  def play_round
    return false if preform_valid_move.nil?

    opponent = opposite_player(current_player)
    opponent_in_check = @board.player_king_in_check?(opponent)
    puts "#{opponent.name}'s King is now in check" if opponent_in_check == true

    puts @board.nodes_by_piece_type_and_player(King, opponent)

    true
  end

  # This isn't a very efficient method, but it does at least work
  # It returns true if it is possible for the player to escape check by making a single move
  # It also returns true if the current player is not in check
  def escape_check?(player)
    in_check = @board.player_king_in_check?(player)
    return true unless in_check

    nodes_with_pieces = @board.nodes_with_player_piece(player)

    # foreach node that has a piece that belongs to the player
    nodes_with_pieces.each do |current_node|
      current_piece = current_node.piece
      moves = current_piece.paths(current_node, @board)
      # foreach move on the piece
      moves.each do |goal_node|
        # simulate a temporary fake move
        current_piece.simulate_move(current_node, goal_node)

        # check if King is still in check
        in_check = @board.player_king_in_check?(player)

        # undo the move
        current_piece.undo_move

        # if no longer in check, then return true
        return true unless in_check
      end
    end

    false
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

  def print_current_player
    puts "It is #{current_player.name}'s turn"
  end
end
