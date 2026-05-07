# frozen-string-literal: true

require_relative 'terminal_colors'

# for printing stuff to the terminal
module Terminal
  def self.print_error(str)
    puts "#{TerminalColors::RED}#{str}#{TerminalColors::RESET}"
  end
end
