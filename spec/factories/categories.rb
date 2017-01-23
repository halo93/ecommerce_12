require "faker"

FactoryGirl.define do
  factory :category do
    name {Faker::Name.name}
    description {Faker::Lorem.sentence}
    depth {Faker::Number.number(1)}
    lft {Faker::Number.number(1)}
    rgt {Faker::Number.number(1)}
  end
end
