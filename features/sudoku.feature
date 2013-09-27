Feature: Showing sudoku
	Upon visiting home page
	User should see a sudoku grid

	Scenario: When the user takes a look at the application
		Given the user has just accessed the home page
		When the grid has loaded
		Then the user should see a 9x9 grid
		And there should a header image

	Scenario: When filling in the grid
		Given the user has just accessed the home page
		When the user inputs an answer into the first cell in the grid
		When the user clicks check answers
		Then the user should see an incorrect answer highlighted
		And a flash message should appear saying 'incorrect values are highlighted'
