# frozen-string-literal: true

require_relative 'grid_settings'
require_relative 'node_drawer'

# draws a specified grid in the terminal
module GridDrawer
  # draws the entire board in the terminal
  def self.draw(grid)
    draw_column_letters
    draw_horizontal_border

    # draw the columns in reverse order so 0th element is at the bottom
    grid.nodes.reverse.each_with_index do |r, r_index_reverse|
      draw_row(r, GridSettings::HEIGHT - r_index_reverse)
    end

    draw_column_letters
  end

  # draws a row number, all nodes in row, and horizontal border
  def self.draw_row(row, row_index)
    draw_row_number(row_index)
    row.each { |node| NodeDrawer.draw_node(node) }
    draw_row_number(row_index)
    print "\n"

    draw_horizontal_border
  end

  # draws all column letters across the width of the grid
  def self.draw_column_letters
    print draw_row_number
    (0...GridSettings::WIDTH).each do |c|
      print ' ' * NodeDrawer::PADDING
      print GridCoordinates::ALPHABET[c]
      print ' ' * NodeDrawer::PADDING
    end
    print "\n"
  end

  # draws a single row number or creates left-right padding if number not specified
  def self.draw_row_number(number = ' ')
    print ' ' * NodeDrawer::PADDING
    print number
    print ' ' * NodeDrawer::PADDING
  end

  # draws a horizontal border that goes across the full width of the board
  def self.draw_horizontal_border
    # apply margin to the left
    draw_row_number

    GridSettings::WIDTH.times do
      print NodeDrawer.horizontal_border
    end
    print "\n"
  end
end
