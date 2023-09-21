require 'rails_helper'
require_relative '../support/new_customer_form.rb'

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

  it "finds a element on the page" do
    visit(customers_path) # using page object i can just call NewCustomerForm.new and the the visit_page method
    click_link("Add Message")
    expect(find("#marina-test").find("h2").find("a")).to have_content("Link for tayatay")
  end

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

  it "creates a customer using page object pattern" do
    # same test as above, following the same steps
    new_customer_form = NewCustomerForm.new # this class is defined in the support folder (see require at top)
    new_customer_form.login.visit_page.fill_in_with( #all of the actions here defined are methos on the other file
      name: Faker::Name.name,
      email: Faker::Internet.email,
      address: Faker::Address.street_address
    ).submit

    expect(page).to have_content("Customer was successfully created.")
  end
end

# 2 step for screenshot setup is:
# # Linux
# apt-get install chromium-chromedriver
# # Mac
# brew install chromedriver
