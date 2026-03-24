class Admin::BaseController < ApplicationController
  before_action :require_login
  before_action :require_admin

  def require_admin
    unless current_user&.admin?
      redirect_to root_path, danger: "権限がありません"
      nil
    end
  end
end
