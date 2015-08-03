FactoryGirl.define do
  factory :social_account do
    customer
    social "facebook"
    social_id Faker::Number.number(15)
  end
end
