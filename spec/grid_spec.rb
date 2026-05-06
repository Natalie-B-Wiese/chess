# rubocop:disable Metrics/BlockLength
# frozen-string-literal: true

require_relative '../lib/board/grid'
require_relative '../lib/piece/piece'
require_relative '../lib/player'
require_relative '../lib/board/grid_settings'
require_relative '../lib/board/grid_coordinates'

describe Grid do
  describe '#initialize' do
    subject(:grid) { described_class.new }
    context 'when calling method' do
      it 'creates an array of @nodes' do
        node_array = grid.instance_variable_get(:@nodes)
        expect(node_array).to be_an(Array)
      end

      it 'size of @nodes is equal to GridSettings::HEIGHT' do
        node_array = grid.instance_variable_get(:@nodes)
        expect(node_array.length).to eq(GridSettings::HEIGHT)
      end

      it '@nodes is a 2D array' do
        node_array = grid.instance_variable_get(:@nodes)
        result = true
        node_array.each do |row|
          if row.is_a?(Array) == false
            result = false
            break
          end
        end
        expect(result).to eq(true)
      end

      it 'each element of @nodes has a size of GridSettings::WIDTH' do
        node_array = grid.instance_variable_get(:@nodes)
        result = true
        node_array.each do |row|
          if row.length != GridSettings::WIDTH
            result = false
            break
          end
        end
        expect(result).to eq(true)
      end

      it '@nodes is a 2D array of Node objects' do
        nodes = grid.instance_variable_get(:@nodes)

        (0...GridSettings::HEIGHT).each do |r|
          (0...GridSettings::WIDTH).each do |c|
            expect(nodes[r][c]).to be_a(Node)
          end
        end
      end

      it 'creates the correct number of Node objects' do
        expect(Node).to receive(:new).exactly(GridSettings::WIDTH * GridSettings::HEIGHT).times
        described_class.new
      end

      it 'passes correct parameters to new Node object' do
        (0...GridSettings::HEIGHT).each do |r|
          (0...GridSettings::WIDTH).each do |c|
            expect(Node).to receive(:new).with(r, c).exactly(1).times
          end
        end

        described_class.new
      end
    end
  end

  describe '#node_at_row_column' do
    subject(:grid) { described_class.new }

    context 'when row is 0 and column is zero' do
      row = 0
      column = 0
      before do
        allow(GridCoordinates).to receive(:position_out_of_bounds?).and_return(false)
      end

      it 'calls position_out_of_bounds with correct parameters' do
        expect(GridCoordinates).to receive(:position_out_of_bounds?).with(column, row)
        grid.node_at_row_column(row, column)
      end

      it 'returns a Node object' do
        result = grid.node_at_row_column(row, column)
        expect(result).to be_a(Node)
      end

      it 'returns correct Node object' do
        # @nodes[row][column]
        result = grid.node_at_row_column(row, column)
        desired_result = grid.instance_variable_get(:@nodes)[row][column]
        expect(result).to eq(desired_result)
      end
    end

    context 'when row is 3 and column is 1' do
      row = 3
      column = 1
      before do
        allow(GridCoordinates).to receive(:position_out_of_bounds?).and_return(false)
      end

      it 'calls position_out_of_bounds with correct parameters' do
        expect(GridCoordinates).to receive(:position_out_of_bounds?).with(column, row)
        grid.node_at_row_column(row, column)
      end

      it 'returns a Node object' do
        result = grid.node_at_row_column(row, column)
        expect(result).to be_a(Node)
      end

      it 'returns correct Node object' do
        # @nodes[row][column]
        result = grid.node_at_row_column(row, column)
        desired_result = grid.instance_variable_get(:@nodes)[row][column]
        expect(result).to eq(desired_result)
      end
    end

    context 'when row and column are out of bounds' do
      row = 30
      column = 120
      before do
        allow(GridCoordinates).to receive(:position_out_of_bounds?).and_return(true)
      end

      it 'calls position_out_of_bounds with correct parameters' do
        expect(GridCoordinates).to receive(:position_out_of_bounds?).with(column, row)
        grid.node_at_row_column(row, column)
      end

      it 'returns nil' do
        result = grid.node_at_row_column(row, column)
        expect(result).to be_nil
      end
    end
  end

  describe '#node_by_id' do
    subject(:grid) { described_class.new }

    context 'when id is A1' do
      id = 'A1'
      row = 0
      column = 0
      let(:desired_result) { instance_double('Node', id: id) }

      before do
        allow(GridCoordinates).to receive(:node_id_to_row_column).and_return([row, column])
        allow(grid).to receive(:node_at_row_column).and_return(desired_result)
      end

      it 'calls #node_id_to_row_column with correct parameter' do
        expect(GridCoordinates).to receive(:node_id_to_row_column).with(id)
        grid.node_by_id(id)
      end

      it 'calls #node_at_row_column with correct parameter' do
        expect(grid).to receive(:node_at_row_column).with(row, column)
        grid.node_by_id(id)
      end

      it 'returns the result of #node_at_row_column' do
        result = grid.node_by_id(id)
        expect(result).to eq(desired_result)
      end
    end

    context 'when id is B3' do
      id = 'B3'
      row = 2
      column = 1
      let(:desired_result) { instance_double('Node', id: id) }

      before do
        allow(GridCoordinates).to receive(:node_id_to_row_column).and_return([row, column])
        allow(grid).to receive(:node_at_row_column).and_return(desired_result)
      end

      it 'calls #node_id_to_row_column with correct parameter' do
        expect(GridCoordinates).to receive(:node_id_to_row_column).with(id)
        grid.node_by_id(id)
      end

      it 'calls #node_at_row_column with correct parameter' do
        expect(grid).to receive(:node_at_row_column).with(row, column)
        grid.node_by_id(id)
      end

      it 'returns the result of #node_at_row_column' do
        result = grid.node_by_id(id)
        expect(result).to eq(desired_result)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
