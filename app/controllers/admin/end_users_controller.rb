class Admin::EndUsersController < ApplicationController
  before_action :authenticate_admin!

  def index #会員一覧
    @end_users = EndUser.page(params[:page])
  end

  def show #会員詳細
    @end_user = EndUser.find(params[:id])
  end

  def edit #会員編集
    @end_user = EndUser.find(params[:id])
  end

  def update #会員情報更新
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      redirect_to admin_end_user_path(@end_user.id), notice: "会員情報の更新に成功しました。"
    else
      render :edit
    end
  end

  private
  def end_user_params               #ニックネーム、メールアドレス、自己紹介文、退会ステータス
    params.require(:end_user).permit(:nicknamem, :email, :introduction, :is_deleted)
  end

end
