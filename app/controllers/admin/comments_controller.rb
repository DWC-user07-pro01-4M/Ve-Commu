class Admin::CommentsController < ApplicationController
  before_action :authenticate_end_user!

  def index
    post = Post.find(params[:post_id])
    comment = current_end_user.comments.new(comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to public_post_path(post)
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to public_post_path(params[:post_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :end_user_id, :post_id)
  end

end