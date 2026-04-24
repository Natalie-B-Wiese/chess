# rubocop:disable Metrics/BlockLength
# frozen-string-literal: true

require_relative '../lib/board/grid'
describe Grid do
  subject(:grid) { described_class.new }
  describe '#initialize' do
    context 'when calling method' do
      it 'creates an array of @nodes' do
        node_array = grid.instance_variable_get(:@nodes)
        expect(node_array).to be_an(Array)
      end

      it 'size of @nodes is equal to HEIGHT' do
        node_array = grid.instance_variable_get(:@nodes)
        expect(node_array.length).to eq(Grid::HEIGHT)
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

      it 'each element of @nodes has a size of WIDTH' do
        node_array = grid.instance_variable_get(:@nodes)
        result = true
        node_array.each do |row|
          if row.length != Grid::WIDTH
            result = false
            break
          end
        end
        expect(result).to eq(true)
      end

      it 'each element of @nodes is an array of Node objects' do
        node_array = grid.instance_variable_get(:@nodes)
        result = true
        node_array.each do |row|
          row.each do |node|
            if node.is_a?(Node) == false
              result = false
              break
            end
          end
        end
        expect(result).to eq(true)
      end

      it 'each Node has correct id of ALPHABET[column_index](row_index+1)' do
        # {ALPHABET[c]}#{r + 1}

        node_array = grid.instance_variable_get(:@nodes)
        result = true
        node_array.each_with_index do |row, row_index|
          row.each_with_index do |node, column_index|
            if node.id != "#{Grid::ALPHABET[column_index]}#{row_index + 1}"
              result = false
              break
            end
          end
        end
        expect(result).to eq(true)
      end
    end
  end

  describe '#node_at_position' do
    context 'when calling it on in-bounds position with 2 parameters' do
      valid_x = 0
      valid_y = 2
      before do
        allow(grid).to receive(:position_out_of_bounds?).with(valid_x, valid_y).and_return(false)
      end

      it 'calls #position_out_of_bounds? with correct parameters' do
        expect(grid).to receive(:position_out_of_bounds?)
        grid.node_at_position(valid_x, valid_y)
      end

      it 'returns a Node' do
        result = grid.node_at_position(valid_x, valid_y)
        expect(result).to be_a(Node)
      end

      it 'returns the correct Node' do
        result = grid.node_at_position(valid_x, valid_y)
        correct_node = grid.instance_variable_get(:@nodes)[valid_y][valid_x]
        expect(result).to eq(correct_node)
      end
    end

    context 'when calling it on in-bounds position with 4 parameters' do
      valid_x = 0
      valid_y = 2
      valid_x_offset = 2
      valid_y_offset = 4

      valid_total_x = valid_x + valid_x_offset
      valid_total_y = valid_y + valid_y_offset

      before do
        allow(grid).to receive(:position_out_of_bounds?).with(valid_total_x, valid_total_y).and_return(false)
      end

      it 'calls #position_out_of_bounds?' do
        expect(grid).to receive(:position_out_of_bounds?)
        grid.node_at_position(valid_x, valid_y, valid_x_offset, valid_y_offset)
      end

      it 'returns a Node' do
        result = grid.node_at_position(valid_x, valid_y, valid_x_offset, valid_y_offset)
        expect(result).to be_a(Node)
      end

      it 'returns the correct Node' do
        result = grid.node_at_position(valid_x, valid_y, valid_x_offset, valid_y_offset)
        correct_node = grid.instance_variable_get(:@nodes)[valid_total_y][valid_total_x]
        expect(result).to eq(correct_node)
      end
    end

    context 'when calling it on out of bounds position' do
      invalid_x = 100
      invalid_y = 200

      before do
        allow(grid).to receive(:position_out_of_bounds?).and_return(true)
      end

      it 'calls #position_out_of_bounds?' do
        expect(grid).to receive(:position_out_of_bounds?)
        grid.node_at_position(invalid_x, invalid_y)
      end

      it 'returns nil' do
        result = grid.node_at_position(invalid_x, invalid_y)
        expect(result).to be_nil
      end
    end
  end

  describe '#position_out_of_bounds?' do
    context 'when position is in bounds' do
      context 'when x and y are 0' do
        x = 0
        y = 0
        it 'returns false' do
          result = grid.position_out_of_bounds?(x, y)
          expect(result).to eq(false)
        end
      end

      context 'when x is 1 less than WIDTH' do
        x = Grid::WIDTH - 1
        y = 0
        it 'returns false' do
          result = grid.position_out_of_bounds?(x, y)
          expect(result).to eq(false)
        end
      end

      context 'when y is 1 less than HEIGHT' do
        x = 0
        y = Grid::HEIGHT - 1
        it 'returns false' do
          result = grid.position_out_of_bounds?(x, y)
          expect(result).to eq(false)
        end
      end
    end

    context 'when out of bounds' do
      context 'when x is equal to WIDTH' do
        x = Grid::WIDTH
        y = 0
        it 'returns true' do
          result = grid.position_out_of_bounds?(x, y)
          expect(result).to eq(true)
        end
      end

      context 'when y is equal to HEIGHT' do
        x = 0
        y = Grid::HEIGHT
        it 'returns true' do
          result = grid.position_out_of_bounds?(x, y)
          expect(result).to eq(true)
        end
      end

      context 'when x is negative' do
        x = -1
        y = 0
        it 'returns true' do
          result = grid.position_out_of_bounds?(x, y)
          expect(result).to eq(true)
        end
      end

      context 'when y is negative' do
        x = 0
        y = -1
        it 'returns true' do
          result = grid.position_out_of_bounds?(x, y)
          expect(result).to eq(true)
        end
      end

      context 'when both x and y are negative' do
        x = -1
        y = -1
        it 'returns true' do
          result = grid.position_out_of_bounds?(x, y)
          expect(result).to eq(true)
        end
      end

      context 'when both x and y are too big' do
        x = 100
        y = 120
        it 'returns true' do
          result = grid.position_out_of_bounds?(x, y)
          expect(result).to eq(true)
        end
      end
    end
  end

  describe '#node_by_id' do
    context 'when id is A1' do
      id = 'A1'
      it 'returns a Node object' do
        result = grid.node_by_id(id)
        expect(result).to be_a(Node)
      end

      it 'returns the node with that id' do
        result = grid.node_by_id(id)
        expect(result.id).to eq(id)
      end

      it 'returns node from @nodes array' do
        result = grid.node_by_id(id)
        node_array = grid.instance_variable_get(:@nodes)
        expect(node_array.flatten).to include(result)
      end
    end

    context 'when id is H8' do
      id = 'H8'
      it 'returns a Node object' do
        result = grid.node_by_id(id)
        expect(result).to be_a(Node)
      end

      it 'returns the node with that id' do
        result = grid.node_by_id(id)
        expect(result.id).to eq(id)
      end

      it 'returns node from @nodes array' do
        result = grid.node_by_id(id)
        node_array = grid.instance_variable_get(:@nodes)
        expect(node_array.flatten).to include(result)
      end
    end

    context 'when id is C3' do
      id = 'C3'
      it 'returns a Node object' do
        result = grid.node_by_id(id)
        expect(result).to be_a(Node)
      end

      it 'returns the node with that id' do
        result = grid.node_by_id(id)
        expect(result.id).to eq(id.upcase)
      end

      it 'returns node from @nodes array' do
        result = grid.node_by_id(id)
        node_array = grid.instance_variable_get(:@nodes)
        expect(node_array.flatten).to include(result)
      end
    end

    context 'when id uses a lowercase letter' do
      id = 'c3'
      it 'returns a Node object' do
        result = grid.node_by_id(id)
        expect(result).to be_a(Node)
      end

      it 'returns the node with that id' do
        result = grid.node_by_id(id)
        expect(result.id).to eq(id.upcase)
      end

      it 'returns node from @nodes array' do
        result = grid.node_by_id(id)
        node_array = grid.instance_variable_get(:@nodes)
        expect(node_array.flatten).to include(result)
      end
    end

    context 'when id is A0' do
      id = 'A0'
      it 'returns nil' do
        result = grid.node_by_id(id)
        expect(result).to be_nil
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
