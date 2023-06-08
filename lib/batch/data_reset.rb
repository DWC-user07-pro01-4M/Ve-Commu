class Batch::DataReset
    # guestuserの投稿を削除
  def self.data_reset
    end_user = EndUser.find_by(email: "guest@example.com")
    end_user.posts.destroy_all
  end
end