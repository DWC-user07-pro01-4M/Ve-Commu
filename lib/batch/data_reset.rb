class Batch::DataReset
  def self.data_reset
    end_user = EndUser.find_by(email: "guest@example.com")
    end_user.posts.destroy_all
    end_user.comments.destroy_all
    end_user.bookmarks.destroy_all
    end_user.likes.destroy_all
  end
end