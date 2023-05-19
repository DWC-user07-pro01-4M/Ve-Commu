class Public::CommentsController < ApplicationController
  before_action :authenticate_end_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.end_user_id = current_end_user.id
    if @comment.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :post_id, :end_user_id)
  end

end
