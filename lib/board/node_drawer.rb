class NodeDrawer
  PADDING = 2
  SIZE = ((PADDING * 2) + 1)

  # draws a node (using print) in the terminal
  def self.draw_node(node)
    print to_s(node)
  end

  def self.to_s(node)
    return "#{left_border} #{right_border}" unless node.full?

    str = '|'
    # the '|' count as part of the size
    str += ' ' * (PADDING - 2)
    str += node.piece.to_s
    str += '|'
    str
  end

  # returns a string for a top or bottom horizontal border
  def self.horizontal_border
    str = '+'
    # the 2 '+' count as part of the size
    str += '-' * (SIZE - 2)
    str += '+'
    str
  end

  def self.left_border
    str = '|'
    # the '|' count as part of the size
    str += ' ' * (PADDING - 1)
    str
  end

  def self.right_border
    # the '|' count as part of the size
    str = ' ' * (PADDING - 1)
    str += '|'
    str
  end
end
