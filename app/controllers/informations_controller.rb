class InformationsController < ApplicationController
  before_action :authenticate_user!

  # 1ページの表示数
  PER_PAGE = 5

  def index
    @informations = Information.order(created_at: :desc).page(params[:page]).per(PER_PAGE)
  end

  def show
    @information = Information.find(params[:id])
  end
end
