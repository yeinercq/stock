FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@mail.com" }
    password { "123456" }
    password_confirmation { "123456" }
    company
  end
end
