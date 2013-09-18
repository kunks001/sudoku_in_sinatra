class Grid

attr_accessor :cells
attr_reader :grid

	def initialize(num = '015003002000100906270068430490002017501040380003905000900081040860070025037204600')
		# "800000000003600000070090200050007000000045700000100030001000068008500010090000400"
		@cells = nil
		@rows = nil
		@boxes = []
		setup(num)
		row_setup
		boxes_setup
		set_cell_neighbours
	end

	def cells
		@cells
	end

	def rows
		@rows
	end

	def boxes
		@boxes
	end

	def setup(num)
		numbers = num.split('')
		@cells = numbers.map {|value| Cell.new(value.to_i) }
	end

	def row_setup
		@rows = cells.each_slice(9).to_a
	end

	def boxes_setup
		slices = (cells.each_slice(9).to_a).each_slice(3).to_a
		slices.each { |box| @boxes << box.transpose }
		return_boxes
	end

	def return_boxes
		boxes = @boxes.flatten!
		@boxes = boxes.each_slice(9).to_a
	end

	def set_cell_neighbours
		cells.each do |c|
			c.neighbours = cell_neighbours(c)
		end
	end

	def values
		cells.map(&:value)
	end

	def solved?
		values.include?(0) ? false: true
	end

	def cell_neighbours(cell)
		[n_row(cell).to_a, (n_column(cell)).to_a, (n_box(cell)).to_a]
	end

	def n_row(cell)
		cell_row = rows.select { |array| array.include?(cell)}.flatten
	end

	def n_column(cell)
		cell_column = rows.transpose.select { |array| array.include?(cell)}.flatten	
	end

	def n_box(cell)
		cell_box = boxes.select { |box| box.include?(cell) }.flatten
	end

	def solve
		before_solving, looping = 81, false

		while !solved? && !looping
			cells.each { |cell|	cell.find_value }
			after_solving = cells.count(&:solved?)
			looping = before_solving == after_solving
			before_solving = after_solving
        end

        guess_next_empty_cell_value unless solved?
	end

	def guess_next_empty_cell_value
		blank_cell = cells.detect{ |c| c.value == 0 }

		neighbour_values = blank_cell.find_neighbour_values 
		blank_cell.find_possible_values(neighbour_values)

		blank_cell.possible_values.each do |value|
			blank_cell.value = value

			grid = replicate_grid(@cells)
			grid.solve

			if grid.solved?
				steal_solution(grid)
				return inspect_board
			end
		end
	end

	def replicate_grid(cells)
		grid = Grid.new(create_grid_string(cells))
	end

	def create_grid_string(cells)
		cells.flatten.map(&:value).join
	end

	def steal_solution(grid)
		@cells = grid.cells
		@rows = grid.rows
		@boxes = grid.boxes
	end

	def inspect_board
		puts "_____________________________________"
		@rows.each do |row|
			row.each { |cell| print "| #{cell.value} " }
			puts "|\n_____________________________________"
		end
	end
end