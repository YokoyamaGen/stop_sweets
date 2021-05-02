class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    use_days = @user.calc_use_day
    @save_money = @user.calc_save_money(use_days)
    @stop_eat_sweets_day = @user.calc_stop_day
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "入力に不備があります。"
      render :edit
    end
  end

  def update_eat_day
    @user = User.find(params[:id])

    if @user.eat_day_updated_on != Date.today && @user.calc_stop_day > 0
      @user.update!(eat_day: @user.eat_day + 1, eat_day_updated_on: Date.today)
    else
      flash[:alert] = "本日はこれ以上、申告できません"
    end
    redirect_back(fallback_location: user_path(@user))
  end

  private

  def user_params
    params.require(:user).permit(:image, :name, :email, :cost, :remove_image)
  end

end
