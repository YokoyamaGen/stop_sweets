class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: :comments_count
  validates :content, presence: true, length: { maximum: 140 }
end
