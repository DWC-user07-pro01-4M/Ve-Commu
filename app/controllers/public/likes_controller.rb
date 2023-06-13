class Public::LikesController < ApplicationController

  def create
    post =  Post.find(params[:post_id])
    like = current_end_user.likes.new(post_id: post.id)
    like.save
    redirect_to posts_path
  end

  def destroy
    post =  Post.find(params[:post_id])
    like = current_end_user.likes.find_by(post_id: post.id)
    like.destroy
    redirect_to books_path
  end

end