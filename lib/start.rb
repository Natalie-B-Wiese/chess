require_relative 'game'

require_relative 'terminal/terminal'
require_relative 'commands/load_command'
require_relative 'commands/new_command'

# initializing this starts the application
class Start
  def initialize
    show_options

    answer = valid_start_command
    case answer
    when 'NEW'
      NewCommand.execute
    when 'LOAD'
      LoadCommand.execute
    else
      puts 'Goodbye!'
    end
  end

  # shows the list of options user can do right now
  def show_options
    content_array = [
      'NEW - creates a new game',
      'LOAD - loads a saved game',
      'QUIT - exits the application'
    ]

    Terminal.create_info_box('OPTIONS:', content_array, 40)
  end

  # prompts the user to enter a command and returns a valid command (NEW, LOAD, or QUIT)
  def valid_start_command
    loop do
      puts 'What would you like to do?'

      answer = gets.chomp.upcase
      return answer if %w[NEW LOAD QUIT].include?(answer)

      Terminal.print_error('Invalid option!')
    end
  end
end
