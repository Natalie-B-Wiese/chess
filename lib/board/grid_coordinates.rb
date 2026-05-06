# frozen-string-literal: true

require_relative 'grid_settings'

# holds conversion and validation methods for grid coordinates
module GridCoordinates
  ALPHABET = %w[A B C D E F G H I J K L M N O P Q R S T U
                V W X Y Z].freeze

  # converts a row column to a letter followed by a 1-based number
  def self.row_column_to_node_id(row, column)
    ALPHABET[column] + (row + 1).to_s
  end

  # returns an array where element 0 is a 0-based row, and element 1 is a 0-based column
  # case insensitive
  def self.node_id_to_row_column(node_id)
    node_id = node_id.upcase
    column_letter = node_id[0]
    column_index = ALPHABET.index(column_letter)
    row_index = Integer(node_id[1]) - 1
    [row_index, column_index]
  end

  # returns an array where element 0 is a 0-based row, and element 1 is a 0-based column
  def self.mirror_row_column(row, column)
    mirrored = []
    mirrored[0] = (GridSettings::HEIGHT - 1) - row
    mirrored[1] = (GridSettings::WIDTH - 1) - column
    mirrored
  end

  def self.mirror_node_id(node_id)
    row, column = node_id_to_row_column(node_id)
    mirrored_row, mirrored_column = mirror_row_column(row, column)
    row_column_to_node_id(mirrored_row, mirrored_column)
  end

  # returns true if the x y position is out of bounds
  # False if the position is in bounds
  # Note: x and y are 0-based
  def self.position_out_of_bounds?(x, y) # rubocop:disable Naming/MethodParameterName
    x.negative? || y.negative? || x >= GridSettings::WIDTH || y >= GridSettings::HEIGHT
  end

  # returns true if the node_id matches the format of a node id
  # Will return false if the node is out of bounds
  def self.valid_node_id?(node_id)
    node_id = node_id.upcase

    return false if node_id.length != 2
    return false unless ALPHABET.include?(node_id[0])
    return false unless Integer(node_id[1]).is_a?(Integer)

    row, column = node_id_to_row_column(node_id)

    !position_out_of_bounds?(column, row)
  end
end
