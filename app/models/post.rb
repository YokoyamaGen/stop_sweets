class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :content, presence: true, length: { maximum: 140 }

  def liked_by?(user)
    likes.any? { |like| like.user_id == user.id }
  end
end
