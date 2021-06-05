class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[edit update destroy]

  def index
    @posts = Post.includes(:user, :likes).order(created_at: "DESC").page(params[:page]).per(5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    (@post.save) ? (redirect_to posts_path) : (render :new)
  end

  def show
    @post = Post.find(params[:id])
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
