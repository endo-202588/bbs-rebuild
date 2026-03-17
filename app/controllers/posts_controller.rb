class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :require_owner, only: %i[show edit update destroy]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      save_tags(@post)
      redirect_to posts_path, success: "新規投稿が完了しました"
    else
      flash.now[:danger] = "新規投稿に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      save_tags(@post)
      redirect_to @post, success: "編集が完了しました"
    else
      flash.now[:danger] = "編集に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, success: "削除しました"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def require_owner
    redirect_to posts_path, danger: "権限がありません" unless @post.owned_by?(current_user)
  end

  def save_tags(post)
    post.tags.clear

    tag_names = params[:tag_names].to_s.split

    tag_names.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      post.tags << tag
    end
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
