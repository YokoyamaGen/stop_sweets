class User < ApplicationRecord
  before_save { self.email = self.email.downcase }
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :email, length: { maximum: 255 }, uniqueness: true
  validates :cost, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :profile, length: { maximum: 160 }

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  mount_uploader :image, ImageUploader

  # 当日中にお菓子を止めた日数をカウントする
  COUNT_STOPDAY_TODAY = 1

  # サービス利用開始日からお菓子を止めた日数を算出する
  def calc_stop_day
    (Date.current - self.created_at.to_date).to_i + COUNT_STOPDAY_TODAY - self.eat_day
  end

  # サービス利用開始時からお菓子を止めたことによる節約金額を算出する
  def save_money
    self.cost * calc_stop_day
  end

  # 1ヶ月間のお菓子を止めたことによる節約金額を算出する
  def save_money_month
    self.cost * calc_stop_day_month
  end

  # 今月のお菓子を止めた日数を算出する
  def calc_stop_day_month
    start_date = if Date.today.beginning_of_month >= self.created_at
      Date.today.beginning_of_month
    else
      self.created_at.to_date
    end

    (Date.today - start_date).to_i  + COUNT_STOPDAY_TODAY - self.eat_day_month
  end

  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザ"
      user.cost = 500
    end
  end
end
