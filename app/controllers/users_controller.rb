class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @users = User.where(id: current_user.id)
  end
end
