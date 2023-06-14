class Public::LikesController < ApplicationController
  before_action :post_params

  def create
    Like.create(end_user_id: current_end_user.id, post_id: params[:id])
    @post.create_notification_like(current_end_user)
  end

  def destroy
    Like.find_by(end_user_id: current_end_user.id, post_id: params[:id]).destroy
  end

  private

  def post_params
    @post = Post.find(params[:id])
  end

end