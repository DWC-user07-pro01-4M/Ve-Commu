class Comment < ApplicationRecord
  belongs_to :end_user
  belongs_to :post

  has_many :notifications, dependent: :destroy

  validates :comment,length:{ maximum: 200}, presence: true
end
