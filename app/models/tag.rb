class Tag < ApplicationRecord

  # タグ機能アソシエーション
  has_many :association_post_and_tags, dependent: :destroy
  has_many :posts, through: :association_post_and_tags, dependent: :destroy

  # バリデーション
  validates :facility_name, tag_type: true

end
