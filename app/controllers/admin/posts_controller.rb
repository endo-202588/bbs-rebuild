class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.includes(:user).order(created_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to admin_posts_path, success: "投稿を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to admin_posts_path, success: "削除しました"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end
