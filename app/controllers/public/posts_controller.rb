class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!

  def index
    @posts = Post.page(params[:page])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to public_post_path(@post), notice: "ありがとうございます。情報のシェアに成功しました。"
    else
      render :new, notice: "残念ながら情報のシェアに失敗しました。"
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to public_post_path(@post), notice: "シェア内容の更新に成功しました。"
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to public_posts_path, notice: "情報を削除しました。"
  end

  private
  def post_params
    params.require(:post).permit(:facility_name, :address, :detailed_description, :image)
  end

end