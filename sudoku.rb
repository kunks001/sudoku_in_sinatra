require 'sinatra'
require_relative './lib/grid'
require_relative './lib/cell'
require_relative './helpers/helpers'

require 'sinatra/partial'
set :partial_template_engine, :erb

require 'rack-flash'
use Rack::Flash

enable :sessions

set :session_secret, "This is the secret key to sign in the cookie"

def random_sudoku
	seed = (1..9).to_a.shuffle + Array.new(72, 0)
	sudoku = Grid.new(seed.join)
	sudoku.solve
	sudoku.values.map(&:to_s)
end

def puzzle(sudoku)
  sudoku = sudoku.dup
  sudoku = sudoku.each_slice(9).to_a

  	while sudoku.flatten.count { |value| value == "0"} < 45
      sudoku.each do |box|
  		x = rand(0..8)
  		box[x] = "0"
    end
	end
	sudoku = sudoku.flatten
  sudoku
end

def hard_puzzle(sudoku)
  sudoku = sudoku.dup
  sudoku = sudoku.each_slice(9).to_a

    while sudoku.flatten.count { |value| value == "0"} < 60
      sudoku.each do |box|
      x = rand(0..8)
      box[x] = "0"
    end
  end
  sudoku = sudoku.flatten
  sudoku
end

def generate_new_puzzle_if_necessary
  return if session[:current_solution]
  sudoku = random_sudoku
  session[:solution] = sudoku
  session[:puzzle] = puzzle(sudoku)
  session[:current_solution] = session[:puzzle]
end

def generate_hard_puzzle
  return if session[:current_solution]
  sudoku = random_sudoku
  session[:solution] = sudoku
  session[:puzzle] = hard_puzzle(sudoku)
  session[:current_solution] = session[:puzzle]
end


def prepare_to_check_solution
  @check_solution = session[:check_solution]
  if @check_solution
    flash[:notice] = "Incorrect values are highlighted in yellow"
  end
  session[:check_solution] = nil
end

def box_order_to_row_order(cells)
  boxes = cells.each_slice(9).to_a
  (0..8).to_a.inject([]) {|memo, i|
    first_box_index = i / 3 * 3
    three_boxes = boxes[first_box_index, 3]
    three_rows_of_three = three_boxes.map do |box| 
      row_number_in_a_box = i % 3
      first_cell_in_the_row_index = row_number_in_a_box * 3
      box[first_cell_in_the_row_index, 3]
    end
    memo += three_rows_of_three.flatten
  }
end
