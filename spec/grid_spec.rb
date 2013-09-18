require './lib/grid'
require './lib/cell'

describe Grid do

let(:grid){Grid.new}
let(:cell){grid.cells[0]}

	context 'should initialise with' do
		it 'with an array of length 81' do
			expect(grid.cells.count).to eq 81
		end
	end

	context 'should when initialising' do
		it 'create and assign values to cell objects' do
			expect(cell.value).to eq 0
		end

		it 'split the grid into rows' do
			expect(grid.rows.count).to eq 9
			expect(grid.rows[0].count).to eq 9
		end

		it 'split the grid into boxes' do
			expect(grid.boxes.count).to eq 9
			expect(grid.boxes[0].count).to eq 9
		end
	end

	context 'should be able to' do
		it 'identify the row a cell in in' do
			expect(grid.n_row(grid.cells[4])).to eq grid.rows[0]
		end

		it 'identify the column a cell is in' do
			expect(grid.n_column(grid.cells[4])).to eq grid.rows.transpose[4]
		end

		it 'identify the box a cell is in' do
			expect(grid.n_box(cell)).to eq grid.boxes[0]
		end	

		it 'return an array of neighbouring row, column & box' do
			expect(grid.cell_neighbours(cell).count).to eq 3
		end

		it 'return an array containing all its neighbours' do
			expect(grid.cell_neighbours(cell).flatten.count).to eq 27
		end

		it 'return an array of cell values' do
			expect(grid.values[0]).to be_an Integer
		end
	end
end
