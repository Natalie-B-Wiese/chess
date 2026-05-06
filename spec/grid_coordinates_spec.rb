# rubocop:disable Metrics/BlockLength
# frozen-string-literal: true

require_relative '../lib/board/grid'
require_relative '../lib/piece/piece'
require_relative '../lib/player'
require_relative '../lib/board/grid_settings'
require_relative '../lib/board/grid_coordinates'

describe GridCoordinates do
  describe '#row_column_to_node_id' do
    context 'when row is 0 and column is 0' do
      row = 0
      column = 0
      expected_result = 'A1'

      it 'returns A1' do
        result = described_class.row_column_to_node_id(row, column)
        expect(result).to eq(expected_result)
      end
    end

    context 'when row is 2 and column is 1' do
      row = 2
      column = 1
      expected_result = 'B3'

      it 'returns B3' do
        result = described_class.row_column_to_node_id(row, column)
        expect(result).to eq(expected_result)
      end
    end
  end

  describe '#node_id_to_row_column' do
    context 'when node_id is A1' do
      node_id = 'A1'

      # the expected results
      goal_row = 0
      goal_column = 0

      result = described_class.node_id_to_row_column(node_id)

      it 'returns an array' do
        expect(result).to be_an(Array)
      end

      it 'returns an array of length 2' do
        expect(result.length).to eq(2)
      end

      it 'returns [0, 0]' do
        expect(result).to eq([goal_row, goal_column])
      end
    end

    context 'when node_id is B3' do
      node_id = 'B3'

      # the expected results
      goal_row = 2
      goal_column = 1

      result = described_class.node_id_to_row_column(node_id)

      it 'returns an array' do
        expect(result).to be_an(Array)
      end

      it 'returns an array of length 2' do
        expect(result.length).to eq(2)
      end

      it 'returns [2, 1]' do
        expect(result).to eq([goal_row, goal_column])
      end
    end

    context 'when node_id is lowercase' do
      node_id = 'b3'

      # the expected results
      goal_row = 2
      goal_column = 1

      result = described_class.node_id_to_row_column(node_id)

      it 'returns an array' do
        expect(result).to be_an(Array)
      end

      it 'returns an array of length 2' do
        expect(result.length).to eq(2)
      end

      it 'returns [2, 1]' do
        expect(result).to eq([goal_row, goal_column])
      end
    end
  end

  describe '#mirror_row_column' do
    context 'when row is 0 and column is 0' do
      row = 0
      column = 0

      mirror_row = GridSettings::HEIGHT - 1
      mirror_column = GridSettings::WIDTH - 1

      result = described_class.mirror_row_column(row, column)

      it 'returns an array' do
        expect(result).to be_an(Array)
      end

      it 'returns an array of length 2' do
        expect(result.length).to eq(2)
      end

      it "returns [#{mirror_row}, #{mirror_column}]" do
        expect(result).to eq([mirror_row, mirror_column])
      end
    end

    context 'when row is 1 and column is 0' do
      row = 1
      column = 0

      mirror_row = GridSettings::HEIGHT - 2
      mirror_column = GridSettings::WIDTH - 1

      result = described_class.mirror_row_column(row, column)

      it 'returns an array' do
        expect(result).to be_an(Array)
      end

      it 'returns an array of length 2' do
        expect(result.length).to eq(2)
      end

      it "returns [#{mirror_row}, #{mirror_column}]" do
        expect(result).to eq([mirror_row, mirror_column])
      end
    end

    context 'when row is 0 and column is 1' do
      row = 0
      column = 1

      mirror_row = GridSettings::HEIGHT - 1
      mirror_column = GridSettings::WIDTH - 2

      result = described_class.mirror_row_column(row, column)

      it 'returns an array' do
        expect(result).to be_an(Array)
      end

      it 'returns an array of length 2' do
        expect(result.length).to eq(2)
      end

      it "returns [#{mirror_row}, #{mirror_column}]" do
        expect(result).to eq([mirror_row, mirror_column])
      end
    end

    context "when row is #{GridSettings::HEIGHT - 1} and column is 0" do
      row = GridSettings::HEIGHT - 1
      column = 0

      mirror_row = 0
      mirror_column = GridSettings::WIDTH - 1

      result = described_class.mirror_row_column(row, column)

      it 'returns an array' do
        expect(result).to be_an(Array)
      end

      it 'returns an array of length 2' do
        expect(result.length).to eq(2)
      end

      it "returns [#{mirror_row}, #{mirror_column}]" do
        expect(result).to eq([mirror_row, mirror_column])
      end
    end

    context "when row is #{GridSettings::HEIGHT - 1} and column is #{GridSettings::WIDTH - 1}" do
      row = GridSettings::HEIGHT - 1
      column = GridSettings::WIDTH - 1

      mirror_row = 0
      mirror_column = 0

      result = described_class.mirror_row_column(row, column)

      it 'returns an array' do
        expect(result).to be_an(Array)
      end

      it 'returns an array of length 2' do
        expect(result.length).to eq(2)
      end

      it "returns [#{mirror_row}, #{mirror_column}]" do
        expect(result).to eq([mirror_row, mirror_column])
      end
    end
  end

  describe '#mirror_node_id' do
    context 'when calling method' do
      id = 'A1'
      row = 0
      column = 0
      goal_id = 'H8'
      mirrored_row = GridSettings::HEIGHT - 1
      mirrored_column = GridSettings::WIDTH - 1

      before do
        allow(described_class).to receive(:node_id_to_row_column).and_return([row, column])
        allow(described_class).to receive(:mirror_row_column).and_return([mirrored_row, mirrored_column])
        allow(described_class).to receive(:row_column_to_node_id).and_return(goal_id)
      end

      it 'calls #node_id_to_row_column with id parameter' do
        expect(described_class).to receive(:node_id_to_row_column).with(id)
        described_class.mirror_node_id(id)
      end

      it 'calls #mirror_row_column with result from #node_id_to_row_column' do
        expect(described_class).to receive(:mirror_row_column).with(row, column)
        described_class.mirror_node_id(id)
      end

      it 'calls #row_column_to_node_id with row and column result from #mirror_row_column' do
        expect(described_class).to receive(:row_column_to_node_id).with(mirrored_row, mirrored_column)
        described_class.mirror_node_id(id)
      end

      it 'returns result of #row_column_to_node_id' do
        result = described_class.mirror_node_id(id)
        expect(result).to eq(goal_id)
      end
    end
  end

  describe '#position_out_of_bounds?' do
    context 'when position is in bounds' do
      context 'when x and y are 0' do
        x = 0
        y = 0
        it 'returns false' do
          result = described_class.position_out_of_bounds?(x, y)
          expect(result).to eq(false)
        end
      end

      context 'when x is 1 less than WIDTH' do
        x = GridSettings::WIDTH - 1
        y = 0
        it 'returns false' do
          result = described_class.position_out_of_bounds?(x, y)
          expect(result).to eq(false)
        end
      end

      context 'when y is 1 less than HEIGHT' do
        x = 0
        y = GridSettings::HEIGHT - 1
        it 'returns false' do
          result = described_class.position_out_of_bounds?(x, y)
          expect(result).to eq(false)
        end
      end
    end

    context 'when out of bounds' do
      context 'when x is equal to WIDTH' do
        x = GridSettings::WIDTH
        y = 0
        it 'returns true' do
          result = described_class.position_out_of_bounds?(x, y)
          expect(result).to eq(true)
        end
      end

      context 'when y is equal to HEIGHT' do
        x = 0
        y = GridSettings::HEIGHT
        it 'returns true' do
          result = described_class.position_out_of_bounds?(x, y)
          expect(result).to eq(true)
        end
      end

      context 'when x is negative' do
        x = -1
        y = 0
        it 'returns true' do
          result = described_class.position_out_of_bounds?(x, y)
          expect(result).to eq(true)
        end
      end

      context 'when y is negative' do
        x = 0
        y = -1
        it 'returns true' do
          result = described_class.position_out_of_bounds?(x, y)
          expect(result).to eq(true)
        end
      end

      context 'when both x and y are negative' do
        x = -1
        y = -1
        it 'returns true' do
          result = described_class.position_out_of_bounds?(x, y)
          expect(result).to eq(true)
        end
      end

      context 'when both x and y are too big' do
        x = 100
        y = 120
        it 'returns true' do
          result = described_class.position_out_of_bounds?(x, y)
          expect(result).to eq(true)
        end
      end
    end
  end

  describe '#valid_node_id?' do
    context 'when node_id has a length that does not equal 2' do
      node_id = 'A120123'
      it 'returns false' do
        result = described_class.valid_node_id?(node_id)
        expect(result).to eq(false)
      end
    end

    context 'when node_id[0] is not a letter' do
      node_id = '61'
      it 'returns false' do
        result = described_class.valid_node_id?(node_id)
        expect(result).to eq(false)
      end
    end

    context 'when node_id[1] is not an integer number' do
      node_id = '6A'
      it 'returns false' do
        result = described_class.valid_node_id?(node_id)
        expect(result).to eq(false)
      end
    end

    context 'when node_id is valid' do
      row = 0
      column = 1
      node_id = 'A2'
      before do
        allow(described_class).to receive(:node_id_to_row_column).and_return([row, column])
        allow(described_class).to receive(:position_out_of_bounds?).and_return(false)
      end

      it 'calls node_id_to_row_column with correct parameter' do
        expect(described_class).to receive(:node_id_to_row_column).with(node_id)
        described_class.valid_node_id?(node_id)
      end

      it 'calls position_out_of_bounds? with correct parameter' do
        expect(described_class).to receive(:position_out_of_bounds?).with(column, row)
        described_class.valid_node_id?(node_id)
      end

      it 'returns true' do
        result = described_class.valid_node_id?(node_id)
        expect(result).to eq(true)
      end
    end

    context 'when node_id is valid and lowercase' do
      row = 0
      column = 1
      node_id = 'a2'
      before do
        allow(described_class).to receive(:node_id_to_row_column).and_return([row, column])
        allow(described_class).to receive(:position_out_of_bounds?).and_return(false)
      end

      it 'calls node_id_to_row_column with correct upcase parameter' do
        expect(described_class).to receive(:node_id_to_row_column).with(node_id.upcase)
        described_class.valid_node_id?(node_id)
      end

      it 'calls position_out_of_bounds? with correct parameter' do
        expect(described_class).to receive(:position_out_of_bounds?).with(column, row)
        described_class.valid_node_id?(node_id)
      end

      it 'returns true' do
        result = described_class.valid_node_id?(node_id)
        expect(result).to eq(true)
      end
    end

    context 'when node_id is valid, but out of bounds' do
      row = 0
      column = 9
      node_id = 'A9'
      before do
        allow(described_class).to receive(:node_id_to_row_column).and_return([row, column])
        allow(described_class).to receive(:position_out_of_bounds?).and_return(true)
      end

      it 'calls node_id_to_row_column with correct parameter' do
        expect(described_class).to receive(:node_id_to_row_column).with(node_id)
        described_class.valid_node_id?(node_id)
      end

      it 'calls position_out_of_bounds? with correct parameter' do
        expect(described_class).to receive(:position_out_of_bounds?).with(column, row)
        described_class.valid_node_id?(node_id)
      end

      it 'returns false' do
        result = described_class.valid_node_id?(node_id)
        expect(result).to eq(false)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
