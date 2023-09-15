require 'rails_helper'

RSpec.describe Order, type: :model do
  it "Has an order" do
    order = create(:order)
    expect(order.customer).to be_a_kind_of(Customer)
  end

  it "Subscribe customer to the new one i created on the it" do
    customer = create(:vip_male)
    order = create(:order, customer: customer)
    expect(order.customer).to be_a_kind_of(Customer)
  end

  it "Has 3 orders" do
    orders = create_list(:order, 3) #it creates 3 orders
    expect(orders.count).to eq(3)
  end

  it "Has 3 orders with an element overwriten" do
    orders = create_list(:order, 3, description: "Test") #overwrites the description
    puts orders.inspect
    expect(orders.count).to eq(3)
  end

  it "Has the dafult number of orders" do
    customer = create(:customer, :with_orders)
    expect(customer.orders.count).to eq(3)
    puts customer.orders
  end

  it "Has as many orders as i want" do
    customer = create(:customer, :with_orders, qtt_orders: 2)
    expect(customer.orders.count).to eq(2)
    puts customer.orders.inspect
  end
end
