require_relative 'piece/bishop'
require_relative 'piece/king'
require_relative 'piece/knight'
require_relative 'piece/pawn'
require_relative 'piece/queen'
require_relative 'piece/rook'

# holds an array of all pieces that a player needs
class PlayerPieces
  attr_reader :pieces

  def initialize(player, board)
    @pieces = []
    create_pieces(player, board)
  end

  def create_pieces(player, board)
    create_king(player, board)
    create_queen(player, board)
    create_rooks(player, board)
    create_bishops(player, board)
    create_knights(player, board)
    create_pawns(player, board)
  end

  private

  def create_king(player, board)
    mirrored = !player.is_white

    # placement for white player
    nodes = %w[E1]

    nodes.map! { |id| Grid.mirror_node_id(id) } if mirrored

    nodes.each do |node_id|
      piece = King.new(player, board)
      board.node_by_id(node_id).set_initial_piece(piece)
      @pieces.push(piece)
    end
  end

  def create_queen(player, board)
    mirrored = !player.is_white

    # placement for white player
    nodes = %w[D1]

    nodes.map! { |id| Grid.mirror_node_id(id) } if mirrored

    nodes.each do |node_id|
      piece = Queen.new(player, board)
      board.node_by_id(node_id).set_initial_piece(piece)
      @pieces.push(piece)
    end
  end

  # creates two rooks and places them in their starting node
  def create_rooks(player, board)
    mirrored = !player.is_white

    # placement for white player
    nodes = %w[A1 H1]

    nodes.map! { |id| Grid.mirror_node_id(id) } if mirrored

    nodes.each do |node_id|
      piece = Rook.new(player, board)
      board.node_by_id(node_id).set_initial_piece(piece)
      @pieces.push(piece)
    end
  end

  def create_bishops(player, board)
    mirrored = !player.is_white

    # placement for white player
    nodes = %w[B1 G1]

    nodes.map! { |id| Grid.mirror_node_id(id) } if mirrored

    nodes.each do |node_id|
      piece = Bishop.new(player, board)
      board.node_by_id(node_id).set_initial_piece(piece)
      @pieces.push(piece)
    end
  end

  def create_knights(player, board)
    mirrored = !player.is_white

    # placement for white player
    nodes = %w[C1 F1]

    nodes.map! { |id| Grid.mirror_node_id(id) } if mirrored

    nodes.each do |node_id|
      piece = Knight.new(player, board)
      board.node_by_id(node_id).set_initial_piece(piece)
      @pieces.push(piece)
    end
  end

  def create_pawns(player, board)
    mirrored = !player.is_white

    # placement for white player
    nodes = %w[A2 B2 C2 D2 E2 F2 G2 H2]

    nodes.map! { |id| Grid.mirror_node_id(id) } if mirrored

    nodes.each do |node_id|
      piece = Pawn.new(player, board)
      board.node_by_id(node_id).set_initial_piece(piece)
      @pieces.push(piece)
    end
  end
end
