class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # 追加・バリデーション
  validates :nickname, length: { minimum: 2, maximum: 10 }, presence: true
  # マイページに画像を添付する
  has_one_attached :image
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.png")
      image.attach(io: File.open(file_path), filename: "no_image.png", content_type: "image/png")
    end
    image.variant(resize: "#{width}x#{height}^", gravity: "center", crop: "#{width}x#{height}+0+0").processed
  end
  # 投稿機能アソシエーション
  has_many :posts, dependent: :destroy

end