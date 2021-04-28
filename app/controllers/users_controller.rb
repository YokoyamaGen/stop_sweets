class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(current_user.id)
    use_days = @user.calc_use_day
    @save_money = @user.calc_save_money(use_days)
    @stop_eat_sweets_day = @user.calc_stop_day
  end

  def update_eat_day
    user = User.find(current_user.id)

    if user.eat_day_updated_on != Date.today && user.calc_stop_day > 0
      user.update!(eat_day: user.eat_day + 1, eat_day_updated_on: Date.today)
    else
      flash[:alert] = "本日はこれ以上、申告できません"
    end
    redirect_back(fallback_location: users_path)
  end
end
