require "faker"

FactoryGirl.define do
  factory :suggest do
    title {Faker::Commerce.product_name}
    content {Faker::Lorem.sentence}
    user_id {Faker::Number.number(1)}
  end
end
