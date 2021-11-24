class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  rescue_from Exception, with: :render_500
  rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError, with: :render_404

  def routing_error
    raise ActionController::RoutingError, params[:path]
  end
  
  protected

  def configure_permitted_parameters
    # サインアップ時のストロングパラメータ
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :cost])
    # アカウント編集時のストロングパラメータ
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image, :cost])
  end

  private

  def render_404(e = nil)
    logger.info "Rendering 404 with exception: #{e.message}" if e
    render file: Rails.root.join('public/404.html'), status: 404, layout: false, content_type: 'text/html'
  end

  def render_500(e = nil)
    logger.error "Rendering 500 with exception: #{e.message}" if e
    render file: Rails.root.join('public/500.html'), status: 500, layout: false, content_type: 'text/html'
  end
end
