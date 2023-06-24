class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_correct_end_user, only: [:destroy]

  def index
    if params[:new_post]
      @posts = Post.new_post
    elsif params[:old_post]
      @posts = Post.old_post
    else
      @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
    end
    if params[:keyword]
      @posts = @posts.search(params[:keyword]).page(params[:page])
    else
      @posts = @posts.page(params[:page])
    end
    @keyword = params[:keyword]
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.end_user = current_end_user
    if post_params[:image].present?
       result = Vision.image_analysis(post_params[:image])
      if result
        if @post.save
          redirect_to post_path(@post), notice: "ありがとうございます。情報のシェアに成功しました。"
        else
          flash.now[:alert] = "情報のシェアに失敗しました。"
          render :new
        end
      else
        flash.now[:alert] = "画像が不適切です。"
        render :new
      end
    else
       if @post.save
         redirect_to post_path(@post), notice: "ありがとうございます。情報のシェアに成功しました。"
       else
          flash.now[:alert] = "必須項目を入力してください。"
         render :new
       end
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
    if post_params[:image].present?
      result = Vision.image_analysis(post_params[:image])
      if result
        if @post.update(post_params)
          redirect_to post_path(@post), notice: "シェア内容の更新に成功しました。"
        else
          flash.now[:alert] = "シェア内容の更新に失敗しました。"
          render :edit
        end
      else
        flash.now[:alert] = "画像が不適切です。"
        render :edit
      end
    else
      if @post.update(post_params)
         redirect_to post_path(@post), notice: "シェア内容の更新に成功しました。"
      else
          flash.now[:alert] = "必須項目を入力してください。"
         render :edit
      end
    end
  end


  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path, notice: "情報を削除しました。"
  end

  private
  def post_params
    params.require(:post).permit(:facility_name, :address, :detailed_description, :image, tag_ids: [])
  end

  def ensure_correct_end_user
    post = Post.find(params[:id])
    unless post.end_user == current_end_user
      redirect_to posts_path, notice: "投稿者以外削除はできません。"
    end
  end

end