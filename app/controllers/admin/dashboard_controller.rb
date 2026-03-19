class Admin::DashboardController < Admin::BaseController
  def index
    @users_count = User.count
    @posts_count = Post.count
    @recent_posts = Post.order(created_at: :desc).limit(5)
  end
end
