class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.new(post_id: params[:post_id], content: comment_params["content"])
    if @comment.save
      redirect_to post_path(params[:post_id])
    else
      @post = Post.find(params[:post_id])
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @comment = Comment.find(params[:post_id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to post_path(params[:post_id])
    else
      @post = Post.find(params[:post_id])
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:post_id])
    @comment.destroy!
    redirect_to post_path(params[:id])
  end


  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end