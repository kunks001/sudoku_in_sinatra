require './spec/spec_helper'
require './sudoku'

describe 'sinatra app home page' do	
	it 'should load the home page' do
	  visit "/"
	  page.should have_content('Made by Srikanth Kunkulagunta')
	end
end