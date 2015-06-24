FactoryGirl.define do
  factory :order do
    total_price { Faker::Commerce.price }
    completed_date { Faker::Date.between(10.days.ago, Date.today) }

    customer
    credit_card

    association :billing_address, factory: :address
    association :shipping_address, factory: :address
  end
end
