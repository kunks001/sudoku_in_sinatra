Bundler.setup(:default, :test)
 
require 'rspec'
require 'capybara/rspec'
# include Capybara::DSL
Capybara.default_driver = :selenium
Capybara.run_server = true
Capybara.app_host = "localhost:4567"

def app
  Sinatra::Application
end

RSpec.configure do |config|
  config.include Capybara::DSL
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end