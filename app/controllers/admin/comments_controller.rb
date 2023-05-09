class Admin::CommentsController < ApplicationController
  before_action :authenticate_end_user!

  def create
    @comment = current_end_user.comments.new(comment_params)
    @comment.post_id = post.id
    @comment.save
    render :index
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render :index
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end

end
