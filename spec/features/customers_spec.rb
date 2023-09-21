require 'rails_helper'

RSpec.feature "Customers", type: :feature do # Cpybara
  it "visits index page" do
    visit(customers_path)
    # print page.html
    save_and_open_page
    expect(page).to have_current_path(customers_path)
  end
end


