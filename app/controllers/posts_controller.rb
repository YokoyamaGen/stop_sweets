class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[edit update destroy]

  # 1ページの表示数
  PER_PAGE = 5

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result.includes(:user, :likes).order(created_at: "DESC").page(params[:page]).per(PER_PAGE)
    # つぶやきが1件も投稿されていなかった場合につぶやき一覧以外のページから遷移された際にメッセージが出力されることを防ぐ
    if request.referer&.include?("posts")
      # 検索バーにキーワードが入力されている状態かつ検索結果がなかった場合にメッセージを出力させる
      flash.now[:alert] = "検索に一致するつぶやきはありませんでした" if @posts.empty? && params[:q][:content_cont].present?
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    (@post.save) ? (redirect_to posts_path) : (render :new)
  end

  def show
    @post = Post.includes(comments: :user).find(params[:id])
    @comment = Comment.new
  end

  def edit
  end

  def update
    (@post.update(post_params)) ? (redirect_to posts_path) : (render :edit)
  end

  def destroy
    @post.destroy!
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end
end
