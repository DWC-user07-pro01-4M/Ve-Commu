class Public::BookmarksController < ApplicationController
  before_action :authenticate_end_user!

  def index
    @bookmarks = Bookmark.page(params[:page])
  end

  def create
    @bookmark = current_end_user.bookmerks.build(bookmark_params)
    @post = @bookmark.post
    if @bookmark.valid?
      @bookmark.save!
      redirect_to post_path(@post), notice: "この投稿をブックマークしました。"
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @post = @bookmark.post
    if @bookmark.destroy
      redirect_to post_path(@post), notice: "ブックマークをはずしました。"
    end

  end

  private
  def bookmark_params
    params.permit(:post_id)
  end

end
