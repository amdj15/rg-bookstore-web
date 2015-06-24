FactoryGirl.define do
  factory :credit_card do
    number { Faker::Number.number(16) }
    # CVV { Faker::Number.number(3) }
    CVV 398
    month "07"
    year "2015"
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }

    customer
  end
end
