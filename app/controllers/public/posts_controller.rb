class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!

  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    # @post = current_end_user.posts.new(post_params)
    if @post.save
      # @post.save_tags(params[:post][:tag])
      redirect_to public_post_path(@post), notice: "ありがとうございます。情報のシェアに成功しました。"
    else
      # @posts = Post.all
      render :index
    end
  end

  def index
    @posts = Post.all
    @post = Post.new
    # @posts = current_end_user.posts.all
    # @post = current_end_user.posts.new
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = current_end_user.comments.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      # @post.save_tags(params[:post][:tag])
      redirect_to public_post_path(@post), notice: "情報の更新に成功しました。"
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to public_posts_path
  end

  private
  def post_params
    params.require(:post).permit(:facility_name, :address, :detailed_description, :image)
  end

end