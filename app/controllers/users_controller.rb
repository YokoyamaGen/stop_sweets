class UsersController < ApplicationController
  before_action :authenticate_user!, :delete_eat_day_month

  def show
    @user = User.find(params[:id])
    use_days = @user.calc_use_day
    @save_money = @user.calc_save_money(use_days)
    @stop_eat_sweets_day = @user.calc_stop_day
    use_days_month = @user.calc_use_day_month
    @save_money_month = @user.calc_save_money(use_days_month)
    @stop_eat_sweets_day_month = @user.calc_stop_day_month
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

  private

  def delete_eat_day_month
    if Date.today == Date.today.beginning_of_month
      @user = User.find(params[:id])
      @user.update!(eat_day_month: 0)
    end
  end
end
