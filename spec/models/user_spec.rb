require 'rails_helper'

RSpec.describe User, type: :model do
  it "有効なユーザーは保存できる" do
    user = build(:user)
    expect(user).to be_valid
  end

  it "emailがないと無効" do
    user = build(:user, email: nil)
    expect(user).to be_invalid
  end

  it "display_nameがないと無効" do
    user = build(:user, display_name: nil)
    expect(user).to be_invalid
  end

  it "first_nameがないと無効" do
    user = build(:user, first_name: nil)
    expect(user).to be_invalid
  end

  it "last_nameがないと無効" do
    user = build(:user, last_name: nil)
    expect(user).to be_invalid
  end

  it "passwordが短いと無効" do
    user = build(:user, password: "123", password_confirmation: "123")
    expect(user).to be_invalid
  end

  it "emailが重複していると無効" do
    user = create(:user)

    duplicate = build(:user)
    duplicate.email = user.email

    expect(duplicate).to be_invalid
  end
end
