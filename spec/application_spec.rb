require './lib/cell'
require './lib/grid'

describe 'application' do

let(:grid){Grid.new}
let(:grid_hard){Grid.new('800000000003600000070090200050007000000045700000100030001000068008500010090000400')}
	
	context 'grid should initialise' do
		it 'with an array of cell objects' do
			expect(grid.cells[0]).to be_an_instance_of Cell
		end
	end

	context 'grid should be able to' do
		it 'tell when it is not solved' do
			expect(grid.solved?).to eq false
		end

		it 'solve an easy sudoku by eliminating possibilities' do
			grid.solve
			expect(grid.values.any?).to_not eq 0
		end

		it 'switch to brute force method when guesswork is needed' do
			expect(grid_hard).to receive(:guess_next_empty_cell_value)
			grid_hard.solve
		end

		it 'make a guess at the value of a cell' do
			grid_hard.solve
			expect(grid_hard.solved?).to eq true
		end

		it 'can form a grid string' do
			expect(grid.create_grid_string(grid.cells)).to be_an_instance_of String
		end

		it 'tell when it is solved' do
			grid.solve
			expect(grid.solved?).to eq true
		end
	end
end
 