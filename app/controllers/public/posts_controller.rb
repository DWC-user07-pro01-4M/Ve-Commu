class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!

  def index #投稿一覧
    @posts = Post.page(params[:page])
  end

  def new #新規投稿
    @post = Post.new
  end

  def create #新規作成
    @post = Post.new(post_params)
    if @post.save
      redirect_to public_post_path(@post), notice: "ありがとうございます。情報のシェアに成功しました。"
    else
      render :new, notice: "残念ながら情報のシェアに失敗しました。"
    end
  end

  def show #投稿詳細
    @post = Post.find(params[:id])
  end

  def edit #投稿編集
    @post = Post.find(params[:id])
  end

  def update #投稿更新
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to public_post_path(@post), notice: "シェア内容の更新に成功しました。"
    else
      render :edit
    end
  end

  def destroy #投稿削除
    post = Post.find(params[:id])
    post.destroy
    redirect_to public_posts_path, notice: "情報を削除しました。"
  end

  private
  def post_params
    params.require(:post).permit(:facility_name, :address, :detailed_description, :image)
  end

end