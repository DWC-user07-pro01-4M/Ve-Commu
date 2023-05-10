class Public::CommentsController < ApplicationController
  before_action :authenticate_end_user!

  def create
    @post = Post.find(params[post:id])
    @comment = current_end_user.comments.new(comment_params)
    @comment.post_id = post.id
    @comment.save
    render :show
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render :show
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end

end
