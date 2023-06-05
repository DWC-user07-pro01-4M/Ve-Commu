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
      if @post.save
         redirect_to post_path(@post), notice: "ありがとうございます。情報のシェアに成功しました。"
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

  def ensure_end_user
    @end_user = EndUser.find(params[:id])
    if @end_user.nickname == "guestuser"
      redirect_to end_user_path(current_end_user) , notice: "ゲストユーザーは編集画面へ遷移できません。"
    end
  end

end