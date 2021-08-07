class Users::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_normal_user, only: %i[update destroy]

  def ensure_normal_user
    if resource.email == "guest@example.com"
      redirect_to user_path(current_user), alert: "ゲストユーザーの更新・削除はできません。"
    end
  end

  def after_sign_up_path_for(resource)
    #アカウント登録後のリダイレクト先
    user_path(resource)
  end

  protected
  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end