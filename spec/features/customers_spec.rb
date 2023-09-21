require 'rails_helper'

RSpec.feature "Customers", type: :feature do # Cpybara # 1 step to screenshot setup is js: true
  it "visits index page" do
    visit(customers_path)
    # print page.html
    # save_and_open_page #this will create a file with all the html code. Capybara shows where the file is saved
    # page.save_screenshot('index_screenshot.png') # To work you have to do the screenshot setup. Install browser
    expect(page).to have_current_path(customers_path)
  end

  # it "has functioning ajax on index" do # This test will give an erro because the setup for js is not made properly (see scrennshot class)
  #   visit(customers_path)
  #   click_link("Add Message")
  #   expect(page).to have_content("Yes!")
  # end

  it "creates a customer" do
    member = create(:member)
    login_as(member, :scope => :member) # Devise scope is if it is an adm, an user... (you set when creating devise)

    visit(new_customer_path)

    fill_in("Name", with: Faker::Name.name)
    fill_in("Email", with: Faker::Internet.email)
    fill_in("Address", with: Faker::Address.street_address)

    click_button("Create Customer")

    expect(page).to have_content("Customer was successfully created.")
  end
end

# 2 step for screenshot setup is:
# # Linux
# apt-get install chromium-chromedriver
# # Mac
# brew install chromedriver
