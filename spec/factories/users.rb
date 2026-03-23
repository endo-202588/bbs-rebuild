FactoryBot.define do
  factory :user do
    email { "test@example.com" }
    password { "password" }
    password_confirmation { "password" }
    display_name { "テストユーザー" }
    first_name { "たろう" }
    last_name { "てすと" }
  end
end
