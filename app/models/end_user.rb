class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :nickname, length: { minimum: 2, maximum: 10 }, presence: true

  # ゲストログイン用のメソッド
  def self.guest
    find_or_create_by!(nickname: "guestuser" ,email: "guest@example.com") do |end_user|
      end_user.password = SecureRandom.urlsafe_base64
      end_user.nickname = "guestuser"
    end
  end
end