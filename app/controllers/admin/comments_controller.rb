class Admin::CommentsController < ApplicationController
  before_action :authenticate_end_user!

  def create
    @post = Post.find(params[:travel_record_id])
    @comment = @post.comments.new(comment_params)
    @comment.end_user_id = current_end_user.id
    if @comment.save
      render :index, notice: "コメントの投稿に成功しました。"
    else
      render :index, notice: "コメントの投稿に失敗しました。"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render :index, notice: "コメントを削除しました。"
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :end_user_id, :post_id)
  end

end