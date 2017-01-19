class Admin::OrdersController < ApplicationController
  load_and_authorize_resource except: :index
  before_action :authenticate_user!, :verify_admin
  layout "admin"

  def index
    params[:limit] ||= Settings.show_limit.show_6
    if params[:q].nil?
      params[:q] = {
        "order_code_or_user_name_cont" => params[:order_code_or_user_name_cont],
        "status_eq" => params[:status_eq]
      }
    end
    @search = Order.ransack params[:q]
    @q = Order.search params[:q]
    @orders_all = @q.result(distinct: true)
      .order_by_updated_time
    respond_to do |format|
      format.html do
        @orders = @orders_all.page(params[:page]).per params[:limit].to_i
      end
      format.xls{send_data Order.to_xls @orders_all}
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

  def edit
  end

  def destroy
  end

  private
  def order_params
    params.permit :id, :status
  end
end
