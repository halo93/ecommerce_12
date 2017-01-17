class Admin::ProductsController < ApplicationController
  load_and_authorize_resource except: :create, find_by: :slug
  before_action :authenticate_user!, :verify_admin, :load_all_categories
  layout "admin"

  def index
    params[:limit] ||= Settings.show_limit.show_6
    @search = Product.ransack params[:q]
    @q = Product.search params[:q]
    @products = @q.result(distinct: true).includes(:category)
      .in_category(params[:category_id]).page(params[:page])
      .per params[:limit].to_i
  end

  def show
  end

  def update
    if @product.update_attributes product_params
      flash[:success] = t ".update_success"
    else
      flash[:danger] = t".update_fail"
    end
    redirect_back fallback_location: :back
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t ".product_created"
    else
      flash[:danger] = t ".fail_to_create"
    end
    redirect_back fallback_location: :back
  end

  def destroy
    if @product.destroy
      flash[:success] = t ".product_deleted"
    else
      flash[:danger] = t ".fail_to_delete"
    end
    redirect_back fallback_location: :back
  end

  def import
    if params[:file].present?
      flag = Product.import params[:file]
      if flag
        flash[:success] = t ".imported"
      else
        flash[:danger] = t ".fail_exist"
      end
    else
      flash[:danger] = t ".fail_to_import"
    end
    redirect_to admin_products_path
  end

  private
  def product_params
    params.require(:product).permit :category_id, :name, :image,
      :price, :in_stock, :description, :id
  end
end
