class Public::CommentsController < ApplicationController
  before_action :authenticate_end_user!

  def create
    @post = Post.find(params[:post_id])
    # @comment = @post.comments.build(comment_params)
    # @comment.end_user_id = current_end_user.id
    @comment = current_end_user.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
    # redirect_to request.referer
      # redirect_to post_path(@post), notice: "コメントを投稿しました。"
      flash.now[:notice] = "コメントを投稿しました"
      render :post_comments
    else
      redirect_to request.referer
    end
  end

  def destroy
    # @comment = Comment.find(params[:id])
    # @comment.destroy
    # redirect_to request.referer
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    # redirect_to post_path(params[:post_id]), alert: "コメントを削除しました。"
    flash.now[:alert] = "投稿を削除しました。"
    @post = Post.find(params[:post_id])
    render :post_comments
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end

end
