class Public::CommentsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_correct_end_user, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.end_user_id = current_end_user.id
    if @comment.save
      @comments = @post.comments
      @post.create_notification_comment(current_end_user, @comment.id)
    else
      redirect_to request.referer, notice: "コメントを送信に失敗しました。"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    @post = Post.find(params[:post_id])
    @comments = @post.comments
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :post_id, :end_user_id)
  end

  def ensure_correct_end_user
    @comment = Comment.find(params[:id])
    unless @comment.end_user == current_end_user
      redirect_to posts_path, notice: "コメントは削除できません。"
    end
  end

end