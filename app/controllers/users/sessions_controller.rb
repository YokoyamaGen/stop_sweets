class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    # ゲストアカウントでログイン
    sign_in User.guest
    # マイページへリダイレクト
    redirect_to user_path(current_user), notice: "ゲストユーザーとしてログインしました。"
  end

  def after_sign_in_path_for(resource)
    #ログイン後のリダイレクト先
    user_path(resource)
  end
end