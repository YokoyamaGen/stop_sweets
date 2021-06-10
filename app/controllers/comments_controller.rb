class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = current_user.comments.new(post_id: params[:post_id], content: comment_params["content"])
    (comment.save) ? (flash[:notice] = "コメントに成功しました") : (flash[:alert] = "コメントに失敗しました")      
    redirect_back(fallback_location: post_path(params[:post_id]))
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

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end