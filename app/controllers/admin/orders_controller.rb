class Admin::OrdersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, :verify_admin
  layout "admin"

  def index
    params[:limit] ||= Settings.show_limit.show_6
    @search = Order.ransack params[:q]
    @q = Order.search params[:q]
    @orders = @q.result(distinct: true)
      .order_by_updated_time.page(params[:page]).per params[:limit].to_i
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

  def edit
  end

  def destroy
  end

  private
  def order_params
    params.permit :id, :status
  end
end
