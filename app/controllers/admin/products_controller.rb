class Admin::ProductsController < ApplicationController
  load_and_authorize_resource except: :create, find_by: :slug
  before_action :authenticate_user!, :verify_admin, :load_all_categories
  layout "admin"

  def index
    params[:limit] ||= Settings.show_limit.show_6
    @product = Product.new
    @products = Product.includes(:category).in_category(params[:category_id])
      .page(params[:page]).per params[:limit].to_i
  end

  def show
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t ".product_created"
    else
      flash[:danger] = t ".fail_to_create"
    end
    redirect_to admin_products_path
  end

  private
  def product_params
    params.require(:product).permit :category_id, :name, :image,
      :product_code, :price, :in_stock
  end
end
