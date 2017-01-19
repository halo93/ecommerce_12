class OrdersController < ApplicationController
  before_action :authenticate_user!, :load_user
  before_action :load_cart, :load_order, only: [:create, :new]
  load_resource only: :update

  def index
    params[:limit] ||= Settings.show_limit.show_6
    @search = @user.orders.ransack params[:q]
    @orders = @user.orders.order_by_creation_time_desc
      .page(params[:page]).per params[:limit].to_i
  end

  def new
    @product_carts = @session_cart.map do |id, cart_params|
      [Product.find_by(id: id), cart_params]
    end
    @total_pay = @order.calc_total_pay @product_carts
  end

  def create
    if @order.update_order! @session_cart,
      params[:address], params[:phone]
      flash[:success] = t ".orders_create_successfully"
      redirect_to root_path
    else
      flash[:danger] = params[:address].empty? ? t(".add_requir") : t(".q_err")
      redirect_back fallback_location: :back
    end
  end

  def update
    unless order_params.nil?
      if @order.update_attributes order_params
        flash[:success] = t ".update_success"
      else
        flash[:notice] = t ".update_fail"
      end
      redirect_back fallback_location: :back
    end
  end

  private
  def load_user
    @user = current_user
    render_404 unless @user
  end

  def load_order
    @order = @user.orders.build
    render_404 unless @user
  end

  def load_cart
    @session_cart = session[:cart]
    redirect_to root_url if @session_cart.blank?
  end

  def order_params
    params.permit :id, :status
  end
end
