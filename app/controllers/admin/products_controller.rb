class Admin::ProductsController < ApplicationController
  load_and_authorize_resource except: :create
  before_action :authenticate_user!, :verify_admin, :load_all_categories
  layout "admin"

  def index
    @product = Product.new
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
