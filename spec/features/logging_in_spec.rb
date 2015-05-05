require 'capybara_helper'

RSpec.describe "Logging into the app", js: true, driver: :poltergeist do
  context "when logging in with an existing account" do
    it "should take you to the dashboard" do
      visit '/'

      sleep(5)
      page.save_screenshot("screenshot.png")

      click_link "Login"

      within("#normal-login") do
        fill_in "email", with: ENV["CAPYBARA_EMAIL"]
        fill_in "password", with: ENV["CAPYBARA_PASSWORD"]
      end

      find('.btn-login').trigger('click')

      expect(page).to have_content("My Review To Do List")

      page.save_screenshot("screenshot.png")
    end
  end
end
