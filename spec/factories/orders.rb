FactoryBot.define do
  factory :order do
    sequence(:description) { |n| "Order N#{n}"}
    customer # here factorybot will look for a factory for it and instace it in here
    # to subscribe the factory association do
    # association :customer, factory: :customer #the association you want to subscribe then the factory you want for it
  end
end
