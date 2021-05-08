class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
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
