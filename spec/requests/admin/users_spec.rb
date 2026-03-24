require 'rails_helper'

RSpec.describe "Admin::Users", type: :request do

  # =========================
  # GET /admin/users
  # =========================
  describe "GET /admin/users" do
    context "未ログインの場合" do
      before { delete logout_path }

      it "ログイン画面にリダイレクト" do
        get admin_users_path
        expect(response).to redirect_to(login_path)
      end
    end

    context "一般ユーザーの場合" do
      let(:user) { create(:user) }
      before { login(user) }

      it "アクセスできない" do
        get admin_users_path
        expect(response).to redirect_to(root_path)
      end
    end

    context "管理者の場合" do
      let(:admin) { create(:user, role: :admin) }
      before { login(admin) }

      it "アクセスできる" do
        get admin_users_path
        expect(response).to have_http_status(:ok)
      end

      it "ユーザー一覧が表示される" do
        user = create(:user, display_name: "テストユーザー")

        get admin_users_path

        expect(response.body).to include(user.display_name)
      end
    end
  end

  # =========================
  # GET /admin/users/:id/edit
  # =========================
  describe "GET /admin/users/:id/edit" do
    let(:target_user) { create(:user) }

    context "未ログインの場合" do
      before { delete logout_path }

      it "ログイン画面にリダイレクト" do
        get edit_admin_user_path(target_user)
        expect(response).to redirect_to(login_path)
      end
    end

    context "一般ユーザーの場合" do
      let(:user) { create(:user) }
      before { login(user) }

      it "アクセスできない" do
        get edit_admin_user_path(target_user)
        expect(response).to redirect_to(root_path)
      end
    end

    context "管理者の場合" do
      let(:admin) { create(:user, role: :admin) }
      before { login(admin) }

      it "アクセスできる" do
        get edit_admin_user_path(target_user)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  # =========================
  # PATCH /admin/users/:id
  # =========================
  describe "PATCH /admin/users/:id" do
    let(:target_user) { create(:user, display_name: "旧") }

    context "未ログインの場合" do
      before { delete logout_path }

      it "更新できない" do
        patch admin_user_path(target_user), params: {
          user: { display_name: "変更" }
        }

        expect(target_user.reload.display_name).not_to eq("変更")
        expect(response).to redirect_to(login_path)
      end
    end

    context "一般ユーザーの場合" do
      let(:current_user) { create(:user) }
      before { login(current_user) }

      it "更新できない" do
        patch admin_user_path(target_user), params: {
          user: { display_name: "変更" }
        }

        expect(target_user.reload.display_name).not_to eq("変更")
        expect(response).to redirect_to(root_path)
      end
    end

    context "管理者の場合" do
      let(:admin) { create(:user, role: :admin) }
      before { login(admin) }

      it "更新できる" do
        patch admin_user_path(target_user), params: {
          user: { display_name: "新しい名前" }
        }

        expect(target_user.reload.display_name).to eq("新しい名前")
        expect(response).to redirect_to(admin_users_path)
        expect(flash[:success]).to eq("ユーザーを更新しました")
      end
    end
  end

end