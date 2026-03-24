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

  describe "DELETE /admin/posts/:id" do
    let(:admin) { create(:user, role: :admin) }
    let!(:post_record) { create(:post) }

    before do
      login(admin)
    end

    it "投稿を削除できる" do
      expect {
        delete admin_post_path(post_record)
      }.to change(Post, :count).by(-1)
    end

    it "削除後リダイレクトされる" do
      delete admin_post_path(post_record)
      expect(response).to redirect_to(admin_posts_path)
    end

    it "フラッシュメッセージが表示される" do
      delete admin_post_path(post_record)
      expect(flash[:success]).to eq("削除しました")
    end

    context "一般ユーザーの場合" do
      let(:user) { create(:user) }
      let!(:post_record) { create(:post) }

      before do
        login(user)
      end

      it "削除できずリダイレクトされる" do
        expect {
          delete admin_post_path(post_record)
        }.not_to change(Post, :count)

        expect(response).to redirect_to(root_path)
      end
    end

    context "未ログインの場合" do
      let!(:post_record) { create(:post) }

      before do
        delete logout_path
      end
      
      it "削除できない" do
        expect {
          delete admin_post_path(post_record)
        }.not_to change(Post, :count)
      end
    end
  end
end
