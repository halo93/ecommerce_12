require "faker"

FactoryGirl.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password "password"
    password_confirmation "password"
    phone {Faker::PhoneNumber.phone_number}
  end

  trait :admin do
    role{User.role[:admin]}
  end
end
