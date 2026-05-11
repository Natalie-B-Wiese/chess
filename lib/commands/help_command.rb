# frozen-string-literal: true

require_relative '../terminal/terminal'
require_relative 'command'

# prints a list of commands
class HelpCommand < Command
  def self.execute
    content_array = [
      'HELP - shows this help box',
      'BOARD - draws board in terminal',
      'PIECES - shows full names of pieces',
      'MOVES - show all available moves',
      'QUIT - exits the game without saving',
      'SAVE - saves the game as a file'
    ]

    Terminal.create_info_box('HELP:', content_array, 40)
  end
end
