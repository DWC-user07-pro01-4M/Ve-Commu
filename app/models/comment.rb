class Comment < ApplicationRecord

  belongs_to :end_user
  belongs_to :post
  belongs_to :admin

  # バリデーション
  validates :comment, presence: true, length: { maximum: 300 }

end
