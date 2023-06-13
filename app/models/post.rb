class Post < ApplicationRecord
  belongs_to :end_user

  has_many :comments, dependent: :destroy
  has_many :association_post_and_tags, dependent: :destroy
  has_many :tags, through: :association_post_and_tags
  has_many :bookmarks, dependent: :destroy
  has_many :likes

  has_one_attached :image

  validates :facility_name, presence: true
  validates :address, presence: true
  validates :detailed_description, presence: true, length: {maximum:200}

  geocoded_by :address
  before_validation :geocode, if: :will_save_change_to_address?
  validate :geocode_must_be_present

  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}

  def Post.search(keyword)
      Post.where("facility_name LIKE(?) OR address LIKE(?) OR detailed_description LIKE(?)", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
  end

  def bookmark_by(end_user)
      Bookmark.find_by(end_user_id: end_user.id, post_id: id)
  end

  def search(keyword)
    if keyword.present?
       where("facility_name LIKE(?) OR address LIKE(?) OR detailed_description LIKE(?)", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
    end
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.png")
      image.attach(io: File.open(file_path), filename: "no_image.png", content_type: "image/png")
    end
    image.variant(resize: "#{width}x#{height}^", gravity: "center", crop: "#{width}x#{height}+0+0").processed
  end

  private

  def geocode_must_be_present
    if latitude.blank? || longitude.blank?
      errors.add(:address, "に関する入力をしてください。")
    end
  end

end