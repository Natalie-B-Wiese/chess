# frozen-string-literal: true

# holds colors that are used by the terminal
module TerminalColors
  WHITE = "\e[47m"
  BLACK = "\e[100m"
  RED = "\e[31m"

  # resets background color, and text color
  RESET = "\e[49m\e[0m"
end
