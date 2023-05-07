class Post < ApplicationRecord

  # 追加
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
  validates :detailed_description, presence: true, length: {maximum:100}

end
