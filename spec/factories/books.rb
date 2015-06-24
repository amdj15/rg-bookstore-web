FactoryGirl.define do
  factory :book do
    title { Faker::Company.catch_phrase }
    price { Faker::Commerce.price }
    books_in_stock { Faker::Number.number(3) }
    description { Faker::Lorem.paragraph(15) }

    author
    category
  end
end
