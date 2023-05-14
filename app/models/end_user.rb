class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ゲストログイン
  def self.guest
    find_or_create_by!(nickname: "guestuser" ,email: "guest@example.com") do |end_user|
      end_user.password = SecureRandom.urlsafe_base64
      end_user.nickname = "guestuser"
    end
  end

  #バリデーション
  validates :nickname, length: { minimum: 2, maximum: 10 }, presence: true

  # 投稿機能アソシエーション
  has_many :posts, dependent: :destroy

  # コメント機能アソシエーション
  has_many :comments, dependent: :destroy

  # ブックマークアソシエーション
  has_many :bookmarks, dependent: :destroy

end