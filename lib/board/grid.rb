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
    (0...HEIGHT).each do |c|
      @nodes.push([])
      (0...WIDTH).each do |r|
        node_id = "#{ALPHABET[c]}#{r}"
        node = Node.new(node_id)
        @nodes[c].push(node)
      end
    end
  end

  # methods:
  # #node_at_position(x, y, x_offset=0, y_offset=0)
  # return nil if x or y is negative
  # return nil if y+y_offset>=HEIGHT
  # return nil if x+x_offset>=WIDTH
  # returns nodes[y+y_offset][x+x_offset]

  # node_by_id(id)
  # Select the node with the specified id from nodes array
end
