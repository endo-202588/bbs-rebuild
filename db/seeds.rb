user = User.first

50.times do |i|
  post = user.posts.create!(
    title: "ダミータイトル#{i + 1}",
    body: "これはダミー本文です。\n#{i + 1}件目の投稿です。\n改行もテストしています。"
  )

  # タグもつける（任意）
  [ "Ruby", "Rails", "初心者" ].sample(2).each do |tag_name|
    tag = Tag.find_or_create_by!(name: tag_name)
    post.tags << tag
  end
end
