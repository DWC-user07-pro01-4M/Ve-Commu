class Public::EndUsersController < ApplicationController
    before_action :authenticate_end_user!
    before_action :ensure_guest_end_user, only: [:edit]
    before_action :is_matching_login_end_user, only: [:edit, :update]

    def show
        @end_user = EndUser.find(current_end_user.id)
    end

    def edit
        is_matching_login_end_user
        @end_user = EndUser.find(current_end_user.id)
    end

    def update
        is_matching_login_end_user
        @end_user = EndUser.find(current_end_user.id)
        if @end_user.update(end_user_params)
            redirect_to end_user_path(current_end_user.id), notice: "編集に成功しました。"
        else
            render :edit #フォームが空の状態ではバリデーションに引っかか編集画面にとどまる
        end
    end

    def unsubscribe
    end

    def withdrawal
        @end_user = EndUser.find(current_end_user.id)
        @end_user.update(is_deleted: true)
        reset_session
        redirect_to root_path, notice: "退会処理が完了しました。ご利用ありがとうございました。"
    end

    def bookmark
        @end_user = EndUser.find(params[:id])
        bookmarks = Bookmark.where(end_user_id: current_end_user.id).pluck(:post_id)
        @bookmarks = Post.find(bookmarks)
    end

    private
    def end_user_params
        params.require(:end_user).permit(:nickname, :email)
    end

    def ensure_guest_end_user
        @end_user = EndUser.find(params[:id])
        if @end_user.nickname == "guestuser"
            redirect_to end_user_path(current_end_user) , notice: "ゲストユーザーは編集画面へ遷移できません。"
        end
    end

    def is_matching_login_end_user
        end_user = EndUser.find(params[:id])
        unless end_user.id == current_end_user.id
            redirect_to end_user_path(current_end_user) , notice: "他ユーザーの編集画面へは遷移できません。"
        end
    end

end