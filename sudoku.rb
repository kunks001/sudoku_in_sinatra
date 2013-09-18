require 'sinatra'
require_relative './lib/grid'
require_relative './lib/cell'

enable :sessions

def random_sudoku
	seed = (1..9).to_a.shuffle + Array.new(72, 0)
	sudoku = Grid.new(seed.join)
	sudoku.solve
	sudoku.boxes_to_s.chars
end

def puzzle(sudoku)
  sudoku = sudoku.dup
	while sudoku.count { |value| value == " "} < 45
		x = rand(1..81)
		sudoku[x] = " "
	end
	sudoku
end

get '/' do
	sudoku = random_sudoku
  session[:solution] = sudoku
  @current_solution = puzzle(sudoku)
  erb :index
end

get '/solution' do
	@current_solution = session[:solution]
  erb :index
end