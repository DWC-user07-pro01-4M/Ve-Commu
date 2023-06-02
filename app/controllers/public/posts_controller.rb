class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!

  def index
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
    @posts = @posts.search(params[:keyword])
    @posts = @posts.page(params[:page])
    @keyword = params[:keyword]
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.end_user = current_end_user
    tags = Vision.get_image_data(post_params[:image])
    if @post.save
      tags.each do |tag|
        @post.tags.create(name: tag)
      end
      redirect_to post_path(@post), notice: "ありがとうございます。情報のシェアに成功しました。"
    else
      flash.now[:alert] = "情報のシェアに失敗しました。"
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments
  end

  def edit
    @post = Post.find(params[:id])
    if @post.end_user == current_end_user
      render :edit
    else
      redirect_to post_path, notice: "投稿者以外編集はできません。"
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "シェア内容の更新に成功しました。"
    else
      flash.now[:alert] = "シェア内容の更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path, notice: "情報を削除しました。"
  end

  private
  def post_params
    params.require(:post).permit(:facility_name, :address, :detailed_description, :images, tag_ids: [])
  end

  def ensure_end_user
    @end_user = EndUser.find(params[:id])
    if @end_user.nickname == "guestuser"
      redirect_to end_user_path(current_end_user) , notice: "ゲストユーザーは編集画面へ遷移できません。"
    end
  end

end