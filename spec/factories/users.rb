FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@moove-it.com" }
    approved true
    password 'testing'
  end
end
