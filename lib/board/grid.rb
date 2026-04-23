# frozen-string-literal: true

require_relative 'node'

# holds a bunch of nodes
class Grid
  WIDTH = 8
  HEIGHT = 8
  ALPHABET = %w[A B C D E F G H I J K L M N O P Q R S T U
                V W X Y Z].freeze

  # creates a grid of nodes
  def initialize
    @nodes = []
    (0...HEIGHT).each do |r|
      @nodes.push([])
      (0...WIDTH).each do |c|
        node_id = "#{ALPHABET[c]}#{r + 1}"
        node = Node.new(node_id)
        @nodes[r].push(node)
      end
    end
  end

  # draws the entire board in the terminal
  def draw_board
    draw_column_letters
    draw_horizontal_border

    # draw the columns in reverse order so 0th element is at the bottom
    @nodes.reverse.each_with_index do |r, r_index_reverse|
      draw_row(r, HEIGHT - r_index_reverse)
    end

    draw_column_letters
  end

  # methods:
  # #node_at_position(x, y, x_offset=0, y_offset=0)
  # return nil if x or y is negative
  # return nil if y+y_offset>=HEIGHT
  # return nil if x+x_offset>=WIDTH
  # returns nodes[y+y_offset][x+x_offset]

  # node_by_id(id)
  # Select the node with the specified id from nodes array

  private

  # draws a row number, all nodes in row, and horizontal border
  def draw_row(row, row_index)
    draw_row_number(row_index)
    row.each { |node| print node }
    draw_row_number(row_index)
    print "\n"

    draw_horizontal_border
  end

  # draws all column letters across the width of the grid
  def draw_column_letters
    print draw_row_number
    (0...WIDTH).each do |c|
      print ' ' * Node::PADDING
      print ALPHABET[c]
      print ' ' * Node::PADDING
    end
    print "\n"
  end

  # draws a single row number or creates left-right padding if number not specified
  def draw_row_number(number = ' ')
    print ' ' * Node::PADDING
    print number
    print ' ' * Node::PADDING
  end

  # draws a horizontal border that goes across the full width of the board
  def draw_horizontal_border
    # apply margin to the left
    draw_row_number

    (0...WIDTH).each do |r|
      print Node.horizontal_border
    end
    print "\n"
  end
end
