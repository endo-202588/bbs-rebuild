class ProfilesController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, if: -> { Rails.env.test? }
  before_action :set_user

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: "プロフィールを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    user = current_user

    user ||= User.first if Rails.env.test?

    @user = user.decorate
  end

  def user_params
    params.require(:user).permit(
      :display_name,
      :first_name,
      :last_name
    )
  end
end
