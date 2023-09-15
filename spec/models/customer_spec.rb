require 'rails_helper'

RSpec.describe Customer, type: :model do

  # fixtures :customers # Here you enter the folder fixtures and calls the file customers
  # # fixtures :all # If you want to load all fixtures

  # it "Creates a customer with fixtures" do
  #   customer = customers(:Marina) # Name of the fixtures then the anme of one of the elements in it
  #   # It will can to the instace the nem and email passed on the fixture
  #   expect(customer.full_name).to eq("Sra. Marina Costa")
  # end

  it "Creates a customer with factorybot" do
    #On factory bot the build is similar to new (without save) and create is the usual create (with save)
    customer = create(:customer)
    expect(customer.full_name).to start_with("Sra. ")
  end

  it "Creates a customer with factorybot overwriting an attribute" do
    customer = create(:customer, name: "Marina Costa") # Only overwritten the anme, the email attributes is still being defined in the factory
    expect(customer.full_name).to eq("Sra. Marina Costa")
  end

  it "Creates a customer with factorybot calling the aliases" do
    customer = create(:user)
    expect(customer.full_name).to start_with("Sra. ")
  end

  it "Expects a vip costumer to have 30 days to pay" do
    customer = create(:customer_vip)
    expect(customer.days_to_pay).to eq(30)
  end

  it "Expects a not vip costumer to have 10 days to pay" do
    customer = create(:customer, vip: false, days_to_pay: 10) #since im using the father class i nedd to define the attributes inside the child, otherwise is not called
    expect(customer.days_to_pay).to eq(10)
  end

  it "Expects a not vip costumer to have 10 days to pay using sublasses on factorybot" do
    customer = create(:customer_not_vip)
    expect(customer.days_to_pay).to eq(10)
  end

  it "creates a customer using attributes_for" do
    attrs = attributes_for(:customer_not_vip) # it gives me a hash of the attrs
    puts attrs
    customer = Customer.create(attrs)
    expect(customer.days_to_pay).to eq(10)
  end

  it "creates a temporary attribute" do
    customer = create(:customer_vip, aaa: true)
    expect(customer.name.upcase).to eq(customer.name)
  end

  it "creates a customer with trait" do
    customer = create(:customer_vip, :male)
    expect(customer.gender).to eq("M")
  end

  it "creates a customer with factories with traits" do
    customer = create(:vip_female)
    expect(customer.gender).to eq("F")
    expect(customer.days_to_pay).to eq(30)
  end

  it { expect{ create(:customer) }.to change{ Customer.all.size}.by(1) }
end
