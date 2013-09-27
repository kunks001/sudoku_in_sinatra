Given(/^the user has just accessed the home page$/) do
	visit('/')
end

When(/^the grid has loaded$/) do
  expect(page.has_xpath?("//div[@id='Sudoku']")).to be_true
end

Then(/^the user should see a (\d+)x(\d+) grid$/) do |arg1, arg2|
  expect(page.has_selector?('input', :count => 83)).to be_true
end

Then(/^there should a header image$/) do
  expect(page.has_xpath?("//img[@id='logo']")).to be_true
end

Given(/^the user inputs an answer into the first cell in the grid$/) do
  fill_in '0', :with => 3
end
 
When(/^the user clicks check answers$/) do
  find(:button, 'check-answers-button').click
end

Then(/^the user should see an incorrect answer highlighted$/) do
  page.should have_css("input.incorrect")
end

Then(/^a flash message should appear saying 'incorrect values are highlighted'$/) do
  page.should have_css("div#flash_notice")
end
