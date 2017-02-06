require "ffaker"

FactoryGirl.define do
  factory :user do |f|
    f.name{FFaker::Name.name}
    email{FFaker::Internet.email}
    phone{FFaker::PhoneNumber.phone_number}
    password "123456"
    password_confirmation "123456"
  end

  trait :admin do
    role{User.role[:admin]}
  end
end
