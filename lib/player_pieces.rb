require_relative 'piece/bishop'
require_relative 'piece/king'
require_relative 'piece/knight'
require_relative 'piece/pawn'
require_relative 'piece/queen'
require_relative 'piece/rook'

require_relative 'board/grid_coordinates'

# holds an array of all pieces that a player needs
class PlayerPieces
  attr_reader :pieces

  def initialize(is_white, board)
    @pieces = []
    create_pieces(is_white, board)
  end

  def create_pieces(is_white, board)
    create_king(is_white, board)
    create_queen(is_white, board)
    create_rooks(is_white, board)
    create_bishops(is_white, board)
    create_knights(is_white, board)
    create_pawns(is_white, board)
  end

  private

  def create_king(is_white, board)
    mirrored = !is_white

    # placement for white player
    nodes = %w[E1]

    nodes.map! { |id| GridCoordinates.mirror_node_id(id) } if mirrored

    nodes.each do |node_id|
      piece = King.new(is_white)
      board.node_by_id(node_id).set_initial_piece(piece)
      @pieces.push(piece)
    end
  end

  def create_queen(is_white, board)
    mirrored = !is_white

    # placement for white player
    nodes = %w[D1]

    nodes.map! { |id| GridCoordinates.mirror_node_id(id) } if mirrored

    nodes.each do |node_id|
      piece = Queen.new(is_white)
      board.node_by_id(node_id).set_initial_piece(piece)
      @pieces.push(piece)
    end
  end

  # creates two rooks and places them in their starting node
  def create_rooks(is_white, board)
    mirrored = !is_white

    # placement for white player
    nodes = %w[A1 H1]

    nodes.map! { |id| GridCoordinates.mirror_node_id(id) } if mirrored

    nodes.each do |node_id|
      piece = Rook.new(is_white)
      board.node_by_id(node_id).set_initial_piece(piece)
      @pieces.push(piece)
    end
  end

  def create_bishops(is_white, board)
    mirrored = !is_white

    # placement for white player
    nodes = %w[B1 G1]

    nodes.map! { |id| GridCoordinates.mirror_node_id(id) } if mirrored

    nodes.each do |node_id|
      piece = Bishop.new(is_white)
      board.node_by_id(node_id).set_initial_piece(piece)
      @pieces.push(piece)
    end
  end

  def create_knights(is_white, board)
    mirrored = !is_white

    # placement for white player
    nodes = %w[C1 F1]

    nodes.map! { |id| GridCoordinates.mirror_node_id(id) } if mirrored

    nodes.each do |node_id|
      piece = Knight.new(is_white)
      board.node_by_id(node_id).set_initial_piece(piece)
      @pieces.push(piece)
    end
  end

  def create_pawns(is_white, board)
    mirrored = !is_white

    # placement for white player
    nodes = %w[A2 B2 C2 D2 E2 F2 G2 H2]

    nodes.map! { |id| GridCoordinates.mirror_node_id(id) } if mirrored

    nodes.each do |node_id|
      piece = Pawn.new(is_white)
      board.node_by_id(node_id).set_initial_piece(piece)
      @pieces.push(piece)
    end
  end
end
