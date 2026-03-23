FactoryBot.define do
  factory :post do
    title { "テストタイトル" }
    body { "テスト本文です" }

    association :user
  end
end
