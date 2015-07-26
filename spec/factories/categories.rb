FactoryGirl.define do
  factory :category do
    sequence(:title) { |n| Faker::Lorem.word + " #{n}" }


    factory :category_with_books do
      transient do
        books_count 5
      end

      after(:create) do |category, evaluator|
        category.books = create_list(:book, evaluator.books_count)
      end
    end
  end
end
