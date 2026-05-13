# frozen-string-literal: true

require_relative 'commands/help_command'
require_relative 'commands/board_command'
require_relative 'commands/pieces_command'
require_relative 'commands/enter_move_command'
require_relative 'commands/save_command'

# interprets user input from the terminal and calls the correct command
module UserInput
  # returns nil if user entered a command or command wasn't recognized
  # returns an array of in-bounds node_ids if user did a move [start_id, end_id]
  def self.gets_and_interpret(game)
    answer = gets.chomp.upcase

    case answer
    when 'HELP'
      HelpCommand.execute
    when 'BOARD'
      BoardCommand.execute(game)
    when 'PIECES'
      PiecesCommand.execute
    when 'MOVES'
      puts 'do something here to show the list of moves of all pieces of this player'
    when 'QUIT'
      return 'QUIT'
    when 'SAVE'
      SaveCommand.execute(game)
    else
      return EnterMoveCommand.execute(answer, game)
    end

    nil
  end
end
