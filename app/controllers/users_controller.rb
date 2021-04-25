class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(current_user.id)
    use_days = @user.calc_use_day
    @save_money = @user.calc_save_money(use_days)
  end
end
