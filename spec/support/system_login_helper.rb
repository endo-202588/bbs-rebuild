module SystemLoginHelper
  def login(user, password: "password")
    visit login_path

    expect(page).to have_field("user_email")

    fill_in "user_email", with: user.email
    fill_in "user_password", with: password

    click_button "ログイン"
  end
end
