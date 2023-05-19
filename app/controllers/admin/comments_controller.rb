class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @comments = Comment.page(params[:page])
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to admin_comments_path(params[:post_id]), notice: "不適切なコメントを削除しました。"
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :post_id, :end_user_id)
  end

end