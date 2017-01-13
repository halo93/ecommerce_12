class Admin::CategoriesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, :verify_admin
  before_action :load_categories_tree, only: [:index, :create]
  layout "admin"

  def index
    params[:limit] ||= Settings.show_limit.show_6
    @search = Category.ransack params[:q]
    @q = Category.search params[:q]
    @categories = @q.result(distinct: true).order(:lft)
      .page(params[:page]).per params[:limit].to_i
  end

  def create
    @category = Category.new category_params
    if @category.update_category params[:parent_id]
      flash[:success] = t ".create_success"
    else
      flash[:danger] = t ".create_fail"
    end
    redirect_back fallback_location: :back
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t ".update_success"
    else
      flash[:danger] = t".update_fail"
    end
    redirect_back fallback_location: :back
  end

  def destroy
    if !@category.is_leaf?
      flash[:danger] = t ".must_be_leaf"
    elsif @category.products.any?
      flash[:danger] = t ".notice_message"
    elsif @category.destroy && @category.delete_category
      flash[:success] = t ".delete_success"
    else
      flash[:notice] = t ".delete_fail"
    end
    redirect_back fallback_location: :back
  end

  private
  def category_params
    params.permit :id, :name, :description
  end

  def load_category
    @category = Category.find_by id: params[:id]
    render_404 unless @category
  end

  def load_categories_tree
    categories = Category.all
    @categories_tree = []
    category_tree categories
  end
end
