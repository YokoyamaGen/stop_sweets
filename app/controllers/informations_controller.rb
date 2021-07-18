class InformationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @informations = Information.all.order(created_at: :desc)
  end

  def show
    @information = Information.find(params[:id])
  end
end
