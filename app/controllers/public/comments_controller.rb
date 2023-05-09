class Public::CommentsController < ApplicationController
  before_action :authenticate_end_user!

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to public_post_path(@post)
    else
      render :show
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :post_id)
  end

end
