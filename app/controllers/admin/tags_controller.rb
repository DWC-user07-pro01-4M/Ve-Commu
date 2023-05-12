class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!

  def index #タグ一覧
    @tag = Tag.new
    @tags = Tag.all
  end

  def create #タグ作成
    @tag = Tag.new(tag_params)
    if @tag.save!
      redirect_to admin_tags_path, notice = "新しいタグを追加しました。"
    else
      @tags = Tag.all
      render :index, notice = "タグの追加に失敗しました。"
    end
  end

  def update #タグ更新
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to admin_tags_pathm notice = "タグの更新に成功しました。"
    else
      @tags = Tag.all
      render :index, notice = "タグの更新に失敗しました。"
    end
  end

  def destroy #タグ削除
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to admin_tags_path, notice = "タグを削除しました。"
  end

  private
  def tag_params
    params.require(:tag).permit(:tag_type, :tag_id)
  end

end
