class Post < ApplicationRecord

  # 投稿機能アソシエーション
  belongs_to :end_user

  # コメント機能アソシエーション
  has_many :comments, dependent: :destroy

  # タグ機能アソシエーション
  has_many :association_post_and_tags, dependent: :destroy
  has_many :tags, through: :association_post_and_tags, dependent: :destroy

  def save_tags(tags)
    tag_list = tags.split(/[[:blank:]]+/)
    current_tags = self.tags.pluck(:tag_type)
    old_tags = current_tags - tag_list
    new_tags = tag_list - current_tags
    p current_tags
    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_type: old)
    end
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
    end
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