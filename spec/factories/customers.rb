FactoryBot.define do
  factory :customer, aliases: [:user] do #Check the fixtures to see the similarities
    # aliases give a name to the factory, to call a specifi one
    name { Faker::Name.name }
    address { Faker::Address.full_address }
    # email { Faker::Internet.email }
    # gender { ["M", "F"].sample }

    # sequence(:email) do |n| #create numerical sequencies
    #   "email#{n}@email.com"
    # end
    sequence(:email, 20) { |n| "email#{n}@email.com" } # same thing as above but one line
    # On the sequence above i defined the number in wich i want it to start. that is optional
    # where i have a number i can also put a leter (as string) and the sequece with be in letters

    transient do # It menas that this atrribute doesent exist unless called upon. Check the after(:create)
      #these are attr that are not on the db
      aaa { false }
      qtt_orders { 3 }
    end

    trait :female do
      gender { "F" }
    end

    trait :male do
      gender { "M" }
    end

    factory :customer_vip do
      vip { true }
      days_to_pay { 30 }
    end

    factory :customer_not_vip do
      vip { false }
      days_to_pay { 10 }
    end

    # Those factories above can also be an trait, and the you can create compilates of the traits you want in specifica factories

    trait :vip do
      vip { true }
      days_to_pay { 30 }
    end

    trait :not_vip do
      vip { false }
      days_to_pay { 10 }
    end

    trait :with_orders do
      after(:create) do |customer, evaluator|
        create_list(:order, evaluator.qtt_orders, customer: customer) #qtt_orders in not on db. here it gets the value passe on the begining of transient method
        # only possible because of the has_many
        # build_list tbm existe
        # create_pair and build_pair are the same as the list but for only 2 elements
        # attributes_for_list the same as attirbutes_for(gets the elements)
        # build_stubbed and build_stubbed_list
      end
    end

    factory :vip_male, traits: [:male, :vip]
    factory :vip_female, traits: [:female, :vip]
    factory :not_vip_male, traits: [:male, :not_vip]
    factory :not_vip_female, traits: [:female, :not_vip]


    after(:create) do |customer, evaluator|
      customer.name.upcase! if evaluator.aaa
    end

  end
end
