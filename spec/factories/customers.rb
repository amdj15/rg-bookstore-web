FactoryGirl.define do
  factory :customer do
    sequence :email do |n|
      "person#{n}@example.com"
    end

    password { Faker::Internet.password(10, 20) }
    password_confirmation { "#{password}" }
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
  end
end
