FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    display_name { "テストユーザー" }
    first_name { "たろう" }
    last_name { "てすと" }
  end
end
