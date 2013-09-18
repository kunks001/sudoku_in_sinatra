require './lib/grid'
require './lib/cell'

describe Cell do

let(:grid){Grid.new}
let(:cell){grid.cells[0]}
let(:cell_eight){Cell.new(8)}
let(:cell_four){Cell.new(4)}
	
	context 'it should initialise with' do
		it 'a value' do
			expect(cell.value).to eq 0
		end
	end

	context 'it should be able to' do
		it 'determine if it needs to find its value' do
			cell_eight.find_value
			expect(cell_eight.value).to eq 8
		end

		it 'find its value' do
			cell.find_value
			expect(cell.value).to_not eq 0
		end

		it 'find its neighbours' do
			expect(cell.find_neighbour_values.count).to eq 27
		end

		it 'retrieve its neighbours values' do
			expect(cell.find_neighbour_values).to include 3,5,7,8,9
		end

		it 'find possible values for itself' do
			expect(cell.find_possible_values([1,2,3,4,5,6])).to eq [7,8,9]
		end
		
		it 'determine if it can set its value' do
			cell.find_possible_values([1,2])
			cell.set_value
			expect(cell.value).to eq 0
		end

		it 'set its value' do
			cell.find_value
			expect(cell.value).to eq 6
		end

		it 'determine if it is solved' do
			expect(cell_eight.solved?).to eq true
		end
	end
end