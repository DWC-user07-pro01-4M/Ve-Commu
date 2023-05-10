class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #バリデーション
  validates :nickname, length: { minimum: 2, maximum: 10 }, presence: true
  # is_deletedがfalseならtrueを返すようバリデーション
  def active_for_authentication?
    super && (is_deleted == false)
  end

  # 投稿機能アソシエーション
  has_many :posts, dependent: :destroy

  # コメント機能アソシエーション
  # has_many :comments, dependent: :destroy

end