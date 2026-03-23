require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:valid_params) do
    {
      post: {
        title: "テスト",
        body: "本文"
      }
    }
  end

  describe "GET /posts" do
    context "未ログインの場合" do
      it_behaves_like "ログイン必須" do
        let(:subject) { get posts_path }
      end
    end

    context "ログイン済の場合" do
      let(:user) { create(:user) }

      before do
        login(user)
      end

      it "正常に表示される" do
        get posts_path
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "POST /posts" do
    context "未ログインの場合" do
      it_behaves_like "ログイン必須" do
        let(:subject) { post posts_path, params: valid_params }
      end

      it "投稿できない" do
        expect {
          post posts_path, params: valid_params
        }.not_to change(Post, :count)

        expect(response).to redirect_to(login_path)
      end
    end

    context "ログイン済の場合" do
      let(:user) { create(:user) }

      before do
        login(user)
      end

      it "投稿できる" do
        expect {
          post posts_path, params: valid_params
        }.to change(Post, :count).by(1)
      end
    end
  end
end
