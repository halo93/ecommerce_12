class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationHelper

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  def default_url_options
    {locale: I18n.locale}
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
