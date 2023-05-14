class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!

  def index #投稿一覧
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
    @posts = @posts.search(params[:keyword])
    @posts = @posts.page(params[:page])
    @keyword = params[:keyword]
  end

  def new #新規投稿
    @post = Post.new
  end

  def create #新規作成
    @post = Post.new(post_params)
    @post.end_user = current_end_user
    if @post.save
      redirect_to post_path(@post), notice: "ありがとうございます。情報のシェアに成功しました。"
    else
      render :new, notice: "残念ながら情報のシェアに失敗しました。"
    end
  end

  def show #投稿詳細
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments
  end

  def edit #投稿編集
    @post = Post.find(params[:id])
    if @post.end_user == current_end_user
      render :edit
    else
      redirect_to post_path, notice: "投稿者以外編集はできません。"
    end
  end

  def update #投稿更新
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "シェア内容の更新に成功しました。"
    else
      render :edit, notice: "内容の更新に失敗しました。"
    end
  end

  def destroy #投稿削除
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path, notice: "情報を削除しました。"
  end

  private
  def post_params
    params.require(:post).permit(:facility_name, :address, :detailed_description, :image, tag_ids: [])
  end

  def ensure_end_user
    @end_user = EndUser.find(params[:id])
    if @end_user.nickname == "guestuser"
      redirect_to end_user_path(current_end_user) , notice: "ゲストユーザーは編集画面へ遷移できません。"
    end
  end

end