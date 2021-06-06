class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, length: { maximum: 255 }
  validates :cost, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  mount_uploader :image, ImageUploader

  def calc_use_day
    (Date.current - self.created_at.to_date).to_i
  end

  def calc_save_money(use_days)
    self.cost * use_days
  end

  def calc_stop_day
    self.calc_use_day - self.eat_day
  end

  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザ"
    end
  end
end
