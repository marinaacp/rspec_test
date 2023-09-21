class NewCustomerForm
  # all the requires necessarys because this file is isolated, it doesent have accesses to any of the programs
  include Capybara::DSL # Capybara
  include FactoryBot::Syntax::Methods # FactoryBot
  include Warden::Test::Helpers # Devise
  include Rails.application.routes.url_helpers # Routes

  def login
    member = create(:member)
    login_as(member, :scope => :member) # Devise scope is if it is an adm, an user... (you set when creating devise)
    self # allow to chain call these methods
  end

  def visit_page
    visit(new_customer_path)
    self
  end

  def fill_in_with(params = {}) # On the test the info is being passed as parameter of the method
    fill_in("Name", with: params.fetch(:name, Faker::Name.name)) # get the :name passed as a parameter on the method, if the doesnt exist call faker to create a new one
    fill_in("Email", with: params.fetch(:email, Faker::Internet.email))
    fill_in("Address", with: params.fetch(:address, Faker::Address.street_address))
    self
  end

  def submit
    click_button("Create Customer")
    self
  end
end
