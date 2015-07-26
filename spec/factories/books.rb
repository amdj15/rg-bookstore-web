FactoryGirl.define do
  factory :book do
    title { Faker::Company.catch_phrase }

    price { Faker::Commerce.price }
    books_in_stock { Faker::Number.number(3) }
    description { Faker::Lorem.paragraph(15) }
    picture File.open(File.join(Rails.root, '/spec/fixtures/files/image.jpg'))

    transient do
      authors_cnt 2
      categories_cnt 2
    end

    after(:build) do |book, evaluator|
      book.categories = create_list(:category, evaluator.categories_cnt)
      book.authors = create_list(:author, evaluator.authors_cnt)
    end
  end
end
