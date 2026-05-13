class GridSettings
  WIDTH = 8
  HEIGHT = 8

  def self.bottom_row
    0
  end

  def self.top_row
    HEIGHT - 1
  end

  def self.left_column
    0
  end

  def self.right_column
    WIDTH - 1
  end
end
