class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :require_owner, only: %i[edit update destroy]

  def index
    q_params = params[:q]&.dup || {}

    # 👇 tagsは自前で処理するので削除
    tag_query = q_params&.delete(:tags_name_cont)

    @q = Post.ransack(q_params)
    @posts = @q.result

    @posts = apply_multi_search(@posts) if q_params.present?

    # 👇 tagsだけ別処理
    if tag_query.present?
      @posts = apply_tag_search(@posts, tag_query)
    end

    @posts = @posts
              .preload(:user, :tags)
              .order(created_at: :desc)
              .page(params[:page])
              .per(9)
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

  def apply_multi_search(posts)
    q = params[:q] || {}

    # 🔍 キーワード
    if q[:title_or_body_cont].present?
      keywords = q[:title_or_body_cont].to_s.split(/\s+/)

      keywords.each do |word|
        posts = posts.where(
          "posts.title ILIKE ? OR posts.body ILIKE ?",
          "%#{word}%", "%#{word}%"
        )
      end
    end

    # 👤 投稿者
    if q[:user_display_name_cont].present?
      names = q[:user_display_name_cont].to_s.split(/\s+/)

      posts = posts.joins(:user)
      names.each do |word|
        posts = posts.where("users.display_name ILIKE ?", "%#{word}%")
      end
    end

    posts.distinct
  end

  def apply_tag_search(posts, tag_query)
    tag_words = tag_query.to_s.split(/\s+/)

    posts.joins(:tags)
        .where(tags: { name: tag_words })
        .group("posts.id")
        .having("COUNT(DISTINCT tags.id) = ?", tag_words.size)
  end

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end
