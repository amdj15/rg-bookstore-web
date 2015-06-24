FactoryGirl.define do
  factory :address do
    address { Faker::Address.street_address }
    zip { Faker::Address.zip }
    city { Faker::Address.city }
    phone { Faker::PhoneNumber.cell_phone }

    country
  end
end
