FactoryGirl.define do
  factory :rating do
    review { Faker::Lorem.paragraph(2) }
    rating { Random.new.rand(1..10) }

    association :item, factory: :book

    factory :customer_rating do
      association :item, factory: :customer
    end
  end
end
