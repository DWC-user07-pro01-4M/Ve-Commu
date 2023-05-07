class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!

  # def new
  #   @post = Post.new
  # end

  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    if @post.save
      redirect_to public_post_path(@post), notice: "ありがとうございます。情報のシェアに成功しました。"
    else
      @posts = Post.all
      render :index
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to public_post_path(@post), notice: "情報の更新に成功しました。"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to public_posts_path
  end

  private
  def post_params
    params.require(:post).permit(:facility_name, :address, :detailed_description, :image)
  end

end
