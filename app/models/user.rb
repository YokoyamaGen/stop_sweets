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

  # サービス利用開始日からお菓子を止めた日数を算出する
  def calc_stop_day
    (Date.current - self.created_at.to_date).to_i - self.eat_day
  end

  # お菓子を止めたことによる節約金額を算出する
  def calc_save_money(stop_eat_sweets_day)
    self.cost * stop_eat_sweets_day
  end

  # 今月のお菓子を止めた日数を算出する
  def calc_stop_day_month
    start_date = if Date.today.beginning_of_month >= self.created_at
      Date.today.beginning_of_month
    else
      self.created_at.to_date
    end

    (Date.today - start_date).to_i  - self.eat_day_month
  end

  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザ"
      user.cost = 500
    end
  end

  def declare_eat
    if eat_day_updated_on != Date.today && calc_stop_day > 0
      update!(eat_day: eat_day + 1, eat_day_month: eat_day_month + 1, eat_day_updated_on: Date.today)
      "本日お菓子を食べたことを申告されました"
    else
      "本日はこれ以上、申告できません"
    end
  end
end
