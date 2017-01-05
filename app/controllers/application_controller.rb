class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationHelper
  before_action :set_locale

  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_path
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def verify_admin
    redirect_to root_path unless current_user.admin?
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
