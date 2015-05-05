require 'rails_helper'

require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  options = {
    debug: false,
    timeout: 10,
    js_errors: false,
    window_size: [1280,960],
  }
  Capybara::Poltergeist::Driver.new(app, options)
end

Capybara.default_driver = :selenium
Capybara.javascript_driver = :selenium
Capybara.app_host = ENV["CAPYBARA_HOST"]
Capybara.default_wait_time = 5


RSpec.configure do |config|
  config.after(:each) do
    Capybara.reset_sessions!
  end
end
