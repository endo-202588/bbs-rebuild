require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let(:user) { create(:user) }

  it "投稿を作成できる" do
    login(user)

    click_link "新規投稿"

    fill_in "タイトル", with: "テスト投稿"
    fill_in "本文", with: "本文です"

    click_button "登録"

    expect(page).to have_content("テスト投稿")
    expect(page).to have_content("本文です")
  end

  it "自分の投稿を編集できる" do
    user = create(:user)
    post = create(:post, user: user, title: "元タイトル", body: "元本文")

    login(user)

    visit post_path(post)

    click_link "編集"

    fill_in "タイトル", with: "更新タイトル"
    fill_in "本文", with: "更新本文"

    click_button "登録"

    expect(page).to have_content("更新タイトル")
    expect(page).to have_content("更新本文")
  end

  it "他人の投稿は編集できない" do
    user = create(:user)
    other_user = create(:user)

    post = create(:post, user: other_user)

    login(user)

    visit post_path(post)

    expect(page).not_to have_link("編集")
  end

  it "自分の投稿を削除できる", js: true do
    user = create(:user)
    post = create(:post, user: user, title: "削除対象")

    login(user)

    visit post_path(post)

    accept_confirm do
      click_link "削除"
    end

    expect(page).not_to have_content("削除対象")
  end

  it "他人の投稿は削除できない" do
    user = create(:user)
    other_user = create(:user)

    post = create(:post, user: other_user)

    login(user)

    visit post_path(post)

    expect(page).not_to have_link("削除")
  end
end
