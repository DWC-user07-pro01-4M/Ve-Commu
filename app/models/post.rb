class Post < ApplicationRecord
  belongs_to :end_user

  has_many :comments,                  dependent: :destroy
  has_many :bookmarks,                 dependent: :destroy
  has_many :likes,                     dependent: :destroy
  has_many :notifications,             dependent: :destroy
  # 投稿モデルとタグモデルを繋ぐ中間テーブルです。
  has_many :association_post_and_tags, dependent: :destroy
  has_many :tags,                      through: :association_post_and_tags

  has_one_attached :image

  validates :facility_name, presence: true
  validates :address, presence: true
  validates :detailed_description, presence: true, length: {maximum:200}
  # 84行目以降のメソッドを呼び出しています。
  validate :geocode_must_be_present

  # 施設住所に緯度と経度の情報が含まれているか、保存する前に確認を行います。
  geocoded_by :address
  before_validation :geocode, if: :will_save_change_to_address?

  scope :new_post, -> {order(created_at: :desc)}
  scope :old_post, -> {order(created_at: :asc)}

  def self.search(keyword)
    self.where("facility_name LIKE ? or address LIKE ? or detailed_description LIKE ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
  end

  def search(keyword)
    if keyword.present?
      where("facility_name LIKE ? or address LIKE ? or detailed_description LIKE ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
    end
  end

  def find_bookmark(end_user)
    bookmarks.find_by(end_user_id: end_user.id)
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.png")
      image.attach(io: File.open(file_path), filename: "no_image.png", content_type: "image/png")
    end
    image.variant(resize: "#{width}x#{height}^", gravity: "center", crop: "#{width}x#{height}+0+0").processed
  end

  def create_notification_like(current_end_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_end_user.id, end_user_id, id, "like"])
          #Notification.where(visitor_id: current_end_user.id, visited_id: end_user_id, post_id: id, action: 'lIKE')
    if temp.blank?
      notification = current_end_user.active_notifications.new(
        post_id: id,
        visited_id: end_user_id,
        action: "like"
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  # def create_notification_like(current_end_user)
  #   return if notifications.exists?(visitor_id: current_end_user.id, visited_id: end_user.id, action: 'like')

  #   notification = current_end_user.active_notifications.build(
  #     post_id: id,
  #     visited_id: end_user_id,
  #     action: "like"
  #   )
  #   notification.checked = true if notification.自分自身か？
  #   notification.save
  # end

  def create_notification_comment(current_end_user, comment_id)
    temp_ids = Comment.select(:end_user_id).where(post_id: id).where.not(end_user_id: current_end_user.id).distinct
    #end_user_ids = Comments.where.not(end_user_id: current_end_user.id).pluck(:end_user_id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment(current_end_user, comment_id, temp_id["end_user_id"])
    end
    save_notification_comment(current_end_user, comment_id, end_user_id) if temp_ids.blank?
  end

  def save_notification_comment(current_end_user, comment_id, visited_id)
    notification = current_end_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: "comment"
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  private

  def geocode_must_be_present
    if latitude.blank? || longitude.blank?
      errors.add(:address, "に関する入力をしてください。")
    end
  end

end