class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    users = User.all
    rank_hash = Hash.new
    users.each do |user|
      rank_hash.merge!(user => user.calc_stop_day_month)
    end
    @rank_info = rank_hash.sort {|(k1, v1), (k2, v2)| v2 <=> v1 }.to_h.to_a
  end

  def show
    @user = User.find(params[:id])
    @stop_eat_sweets_day = @user.calc_stop_day
    @save_money = @user.calc_save_money(@stop_eat_sweets_day)
    @stop_eat_sweets_day_month = @user.calc_stop_day_month
    @save_money_month = @user.calc_save_money(@stop_eat_sweets_day_month)
  end

  def update_eat_day
    @user = User.find(params[:id])

    if @user.eat_day_updated_on != Date.today && @user.calc_stop_day > 0
      @user.update!(eat_day: @user.eat_day + 1, eat_day_month: @user.eat_day_month + 1, eat_day_updated_on: Date.today)
    else
      flash[:alert] = "本日はこれ以上、申告できません"
    end
    redirect_back(fallback_location: user_path(@user))
  end
end
