require 'rails_helper'

RSpec.describe "Admin::Posts", type: :request do
  describe "GET /admin/posts" do
    context "未ログインの場合" do
      it "ログイン画面にリダイレクトされる" do
        get admin_posts_path
        expect(response).to redirect_to(login_path)
      end
    end

    context "一般ユーザーの場合" do
      let(:user) { create(:user) }

      before do
        login(user)
      end

      it "アクセスできない" do
        get admin_posts_path
        expect(response).to redirect_to(root_path)
      end
    end

    context "管理者ユーザーの場合" do
      let(:admin) { create(:user, role: :admin) }

      before do
        login(admin)
      end

      it "アクセスできる" do
        get admin_posts_path
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
