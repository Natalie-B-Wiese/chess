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
        node_id = Grid.row_column_to_node_id(r, c)
        node = Node.new(node_id)
        @nodes[r].push(node)
      end
    end
  end

  # converts a row column to a letter followed by a 1-based number
  def self.row_column_to_node_id(row, column)
    ALPHABET[column] + (row + 1).to_s
  end

  # returns an array where element 0 is a 0-based row, and element 1 is a 0-based column
  def self.node_id_to_row_column(node_id)
    column_letter = node_id[0]
    column_index = ALPHABET.index(column_letter)
    row_index = node_id[1].to_i - 1
    [row_index, column_index]
  end

  # returns an array where element 0 is a 0-based row, and element 1 is a 0-based column
  def self.mirror_row_column(row, column)
    mirrored = []
    mirrored[0] = (HEIGHT - 1) - row
    mirrored[1] = (WIDTH - 1) - column
    mirrored
  end

  def self.mirror_node_id(node_id)
    row, column = Grid.node_id_to_row_column(node_id)
    mirrored_row, mirrored_column = Grid.mirror_row_column(row, column)
    row_column_to_node_id(mirrored_row, mirrored_column)
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
  # Note: x and y are 0-based
  # return nil if out of bounds
  # Otherwise, it returns nodes[y+y_offset][x+x_offset]
  def node_at_position(x, y, x_offset = 0, y_offset = 0)
    return nil if position_out_of_bounds?(x + x_offset, y + y_offset)

    @nodes[y + y_offset][x + x_offset]
  end

  # returns true if the x y position is out of bounds
  # False if the position is in bounds
  # Note: x and y are 0-based
  def position_out_of_bounds?(x, y)
    x.negative? || y.negative? || x >= WIDTH || y >= HEIGHT
  end

  # node_by_id(id)
  # Uses case-insensitive search to return the node with the specified id from nodes array
  # Returns nil if the node with the id doesn't exist
  def node_by_id(id)
    id = id.upcase
    nodes_with_id = @nodes.flatten.select { |node| node.id == id }

    return nil if nodes_with_id.empty?

    # there should only be one node with the specified id
    nodes_with_id[0]
  end

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
