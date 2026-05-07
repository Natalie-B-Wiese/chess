# frozen-string-literal: true

require_relative 'terminal_colors'

# for printing stuff to the terminal
module Terminal
  CORNER = '+'
  V_EDGE = '-'
  H_EDGE = '|'

  def self.print_error(str)
    puts "#{TerminalColors::RED}#{str}#{TerminalColors::RESET}"
  end

  def self.create_info_box(header, content_array, width)
    draw_header_box(header, width)

    # decrease width by 2 to ignore the H_EDGE on either side
    width -= 2

    content_array.each do |line|
      puts H_EDGE + padded_string(line, width) + H_EDGE
    end

    puts CORNER + (V_EDGE * width) + CORNER
  end

  def self.draw_header_box(header, width)
    # decrease width by 2 to ignore the H_EDGE on either side
    width -= 2

    puts CORNER + (V_EDGE * width) + CORNER
    puts H_EDGE + centered_string(header, width) + H_EDGE
    puts CORNER + (V_EDGE * width) + CORNER
  end

  # returns a string that is horizontally centered
  def self.centered_string(string, width)
    padding_left = (width / 2) - (string.length / 2)
    padded_string(string, width, padding_left)
  end

  # pads the string a specified amount on the left, and pads it the remaining amount on the right
  def self.padded_string(string, width, left_padding = 1)
    (' ' * left_padding) + string + (' ' * (width - string.length - left_padding))
  end
end
