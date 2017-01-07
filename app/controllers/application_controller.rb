class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationHelper
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_path
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def verify_admin
    redirect_to root_path unless current_user.admin?
  end

  def after_sign_in_path_for resource
    if resource.admin?
      admin_root_path
    else
      session[:previous_url] || root_path
    end
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  protected
  def configure_permitted_parameters
    attrs = [:name, :email, :password, :current_password]
    devise_parameter_sanitizer.permit :account_update, keys: attrs
  end
end
