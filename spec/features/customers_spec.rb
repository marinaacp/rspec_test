require 'rails_helper'

RSpec.feature "Customers", type: :feature do # Cpybara # 1 step to screenshot setup is js: true
  it "visits index page" do
    visit(customers_path)
    # print page.html
    # save_and_open_page #this will create a file with all the html code. Capybara shows where the file is saved
    # page.save_screenshot('index_screenshot.png') # To work you have to do the screenshot setup. Install browser
    expect(page).to have_current_path(customers_path)
  end

  it "creates a customer" do
    
  end
end

# 2 step for screenshot setup is:
# # Linux
# apt-get install chromium-chromedriver
# # Mac
# brew install chromedriver
