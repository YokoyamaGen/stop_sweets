class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    # ゲストアカウントでログイン
    sign_in User.guest
    # マイページへリダイレクト
    redirect_to user_path(current_user), notice: "ゲストユーザーとしてログインしました。"
  end
end