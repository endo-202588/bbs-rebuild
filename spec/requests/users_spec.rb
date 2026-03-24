require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users/new" do
    it "新規登録画面が表示される" do
      get new_user_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /users" do
    let(:valid_params) { { user: attributes_for(:user) } }

    it "正常にユーザーが作成される" do
      expect {
        post users_path, params: valid_params
      }.to change(User, :count).by(1)

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(posts_path)
    end

    it "不正な場合はユーザー作成されない" do
      invalid = valid_params.deep_dup
      invalid[:user][:email] = ""

      expect {
        post users_path, params: invalid
      }.not_to change(User, :count)

      expect(response).to have_http_status(:unprocessable_content)
    end

    it "passwordとconfirmationが違うと作成されない" do
      invalid = valid_params.deep_dup
      invalid[:user][:password_confirmation] = "wrong"

      expect {
        post users_path, params: invalid
      }.not_to change(User, :count)

      expect(response).to have_http_status(:unprocessable_content)
    end

    it "emailが重複していると作成されない" do
      user = create(:user)

      params = { user: attributes_for(:user, email: user.email) }

      expect {
        post users_path, params: params
      }.not_to change(User, :count)

      expect(response).to have_http_status(:unprocessable_content)
    end
  end
end
