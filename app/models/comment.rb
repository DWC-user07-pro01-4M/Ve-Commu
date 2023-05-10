class Comment < ApplicationRecord

  belongs_to :end_user
  belongs_to :post
  # バリデーション
  validates :comment,length:{ maximum: 200}, presence: true

end
