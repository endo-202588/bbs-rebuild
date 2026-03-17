class UserSessionsController < ApplicationController
  skip_before_action :require_login

  def new
    @user = User.new
  end

  def create
    @user = User.new(login_params)

    if login(@user.email, @user.password)
      redirect_to posts_path, success: "ログインしました"
    else
      flash.new[:danger] = "メールまたはパスワードが違います"
      render :new, status: :unprocessable_entity
    end
  end


  def destroy
    logout
    redirect_to root_path, success: "ログアウトしました"
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
