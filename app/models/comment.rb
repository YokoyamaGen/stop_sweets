class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  counter_culture :post
  validates :content, presence: true, length: { maximum: 140 }
end
