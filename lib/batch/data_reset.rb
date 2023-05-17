class Batch::DataReset
  # ここに定期実行する処理を記述する。
    # guestuserの投稿を削除
  def self.data_reset
    end_user = EndUser.find_by(email: "guest@example.com")
    end_user.posts.destroy_all
    end_user.comments.destroy_all
    end_user.bookmarks.destroy_all
    p "ゲストユーザーの投稿を全て削除しました"
  end
end