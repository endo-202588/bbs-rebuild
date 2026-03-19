class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[edit update destroy]
  
  def index
    @users = User.order(created_at: :desc).decorate
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, success: "ユーザーを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, success: "ユーザーを削除しました"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:role)
  end
end
