class Post < ApplicationRecord

  # 投稿機能アソシエーション
  belongs_to :end_user

  # コメント機能アソシエーション
  has_many :comments, dependent: :destroy

  # タグ機能アソシエーション
  has_many :association_post_and_tags, dependent: :destroy
  has_many :tags, through: :association_post_and_tags

  # キーワード検索
  def self.ransackable_attributes(auth_object = nil)
      ["created_at", "end_user_id", "id", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["association_post_and_tags", "comments", "end_user", "image_attachment", "image_blob", "tags"]
  end

  # 画像
  has_one_attached :image
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.png")
      image.attach(io: File.open(file_path), filename: "no_image.png", content_type: "image/png")
    end
    image.variant(resize: "#{width}x#{height}^", gravity: "center", crop: "#{width}x#{height}+0+0").processed
  end
  # バリデーション
  validates :facility_name, presence: true
  validates :address, presence: true
  validates :detailed_description, presence: true, length: {maximum:200}

end