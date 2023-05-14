class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def index #コメント一覧
    @end_users = EndUser.all
    @comments = Comment.page(params[:page])
  end

  def show #コメント詳細
    @end_user = EndUser.find(params[:id])
    @comment = Comment.find(params[:id])
  end

  def destroy #コメント削除
    Comment.find(params[:id]).destroy
    redirect_to admin_comments_path(params[:post_id]), notice: "不適切なコメントを削除しました。"
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end

end