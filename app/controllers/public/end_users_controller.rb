class Public::EndUsersController < ApplicationController
    before_action :authenticate_end_user!

    def show
        @end_user = EndUser.find(current_end_user.id)
    end

    def edit
        @end_user = EndUser.find(current_end_user.id)
    end

    def update
        @end_user = EndUser.find(current_end_user.id)
        if @end_user.update(end_user_params)
            redirect_to end_user_path(current_end_user.id), notice: "編集に成功しました。"
        else
            render :edit, notice: "編集に失敗しました。"
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

    private
    def end_user_params
        params.require(:end_user).permit(:nickname, :email)
    end

end