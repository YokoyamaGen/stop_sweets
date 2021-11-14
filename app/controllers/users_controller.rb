class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    # ユーザが1ヶ月間お菓子を止めた日数のランキングを表示するSQL。
    # ランキングの算出方法は本日 - 月初（もし、月初以降にアプリを使い始めた場合、アプリを使い始めた日） - お菓子を食べてしまった日数
    # ランキングに表示可能なユーザは100名までとする。
    @users = User.find_by_sql(
    "SELECT *, DENSE_RANK() OVER(ORDER BY STOP_DAY DESC) AS RANK
     FROM (SELECT ID, NAME, IMAGE,
            (CASE
              WHEN CAST(CREATED_AT AS DATE) > CAST(DATE_TRUNC('MONTH', NOW()) AS DATE)
              THEN CURRENT_DATE - CAST(CREATED_AT AS DATE) - EAT_DAY_MONTH
              ELSE CURRENT_DATE - CAST(DATE_TRUNC('MONTH', NOW()) AS DATE) - EAT_DAY_MONTH END) AS STOP_DAY
           FROM USERS) AS STOP_DAY_COUNT
     LIMIT 100")
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
      flash[:notice] = "本日お菓子を食べたことを申告されました"
    else
      flash[:alert] = "本日はこれ以上、申告できません"
    end
    redirect_back(fallback_location: user_path(@user))
  end
end
