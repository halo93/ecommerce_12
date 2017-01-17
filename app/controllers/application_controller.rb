class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationHelper
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :new_suggestion, :load_categories_tree
  layout :layout_by_resource

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

  def load_all_categories
    @categories = Category.order(:lft).select :name, :id, :depth
  end

  def new_suggestion
    @suggest = Suggest.new
  end

  def load_user
    @user = User.find_by id: params[:id]
    render_404 unless @user
  end

  def load_all_users
    @users = User.select :name, :email, :avatar, :created_at, :sign_in_count,
      :role
  end

  def load_suggested_product
    @suggest = Suggest.find_by id: params[:id]
    @suggest ? @suggest : render_404
  end

  def category_tree categories, left = 0, right = nil, depth = -1
    categories.each do |category|
      next unless category.lft > left && (right.nil? || category.rgt <
        right) && category.depth == depth + 1
      @categories_tree.push(category)
      categories_temp = categories.compact
      categories_temp.delete category
      if category.rgt != (category.lft + 1)
        category_tree categories_temp, category.lft,
          category.rgt, category.depth
      end
    end
    @categories_tree
  end

  def load_categories_tree
    categories = Category.all
    @categories_tree = []
    category_tree categories
  end

  protected
  def configure_permitted_parameters
    attrs = [:name, :email, :password, :current_password, :avatar]
    devise_parameter_sanitizer.permit :account_update, keys: attrs
    devise_parameter_sanitizer.permit :sign_up, keys: attrs
  end

  def layout_by_resource
    if devise_controller? && (action_name == "edit" || action_name == "update")
      if current_user.nil?
        "application"
      else
        current_user.admin? ? "admin" : "application"
      end
    end
  end
end
