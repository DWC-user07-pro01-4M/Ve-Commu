class Bookmark < ApplicationRecord
  belongs_to :end_user
  belongs_to :post
  # 重複したお気に入り登録ができないようにバリデーション
  validates :end_user_id, uniqueness: { scope: :post_id }
end
