class Cell

attr_accessor :value
attr_accessor :neighbours

	def initialize(value)
		@value = value
		@possible_values = []
		@neighbours = nil	
	end

	def inspect
		"cell: #{value}"
	end

	def value
		@value
	end

	def possible_values
		@possible_values
	end

	def neighbours
		@neighbours
	end

	def find_value
		if value == 0
			neighbour_values = find_neighbour_values 
			find_possible_values(neighbour_values)
			set_value
		end
	end

	def find_neighbour_values
		neighbours.flatten.map!(&:value)
	end

	def find_possible_values(neighbour_values)
		for n in (1..9)
			@possible_values << n unless neighbour_values.include?(n)
		end	
		possible_values
	end

	def set_value
		if @possible_values.count == 1
			@value = @possible_values.shift
		else
			@possible_values = []
		end
	end

	def solved?
		@value != 0
	end
end