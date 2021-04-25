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
    user.update!(eat_day: user.eat_day + 1) if user.calc_stop_day > 0
    redirect_back(fallback_location: users_path)
  end
end
