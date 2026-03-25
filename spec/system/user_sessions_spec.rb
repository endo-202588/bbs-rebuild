require 'rails_helper'

RSpec.describe "Login", type: :system do
  let(:user) { create(:user) }

  it "ログインできる" do
    visit login_path

    fill_in "user_email", with: user.email
    fill_in "user_password", with: "password"

    click_button "ログイン"

    expect(page).to have_current_path(posts_path)
    expect(page).to have_content(user.display_name)
  end

  it "ログインに失敗する" do
    user = create(:user)

    visit login_path

    fill_in "user_email", with: user.email
    fill_in "user_password", with: "wrong_password"

    click_button "ログイン"

    expect(page).to have_current_path(login_path)
    expect(page).to have_content("メールまたはパスワードが違います")
  end
end
