class Admin::CategoriesController < ApplicationController
  load_and_authorize_resource except: :create
  before_action :authenticate_user!, :verify_admin
  before_action :load_all_categories
  layout "admin"

  def index
    params[:limit] ||= Settings.show_limit.show_6
    @categories = Category.order_by_creation_time
      .page(params[:page]).per params[:limit]
  end

  def create
    @category = Category.new category_params
    if @category.update_category params[:parent_id]
      flash[:success] = t ".create_success"
    else
      flash[:danger] = t ".create_fail"
    end
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.permit :name, :description
  end
end
