class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  rescue_from Exception, with: :render_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  protected

  def configure_permitted_parameters
    # サインアップ時のストロングパラメータ
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :cost])
    # アカウント編集時のストロングパラメータ
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image, :cost])
  end

  private

  def render_500
    render file: Rails.root.join('public/500.html'), status: 404, layout: false, content_type: 'text/html'
  end

  def render_404
    render file: Rails.root.join('public/404.html'), status: 404, layout: false, content_type: 'text/html'
  end
end
