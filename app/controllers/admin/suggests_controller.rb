class Admin::SuggestsController < ApplicationController
  load_and_authorize_resource except: [:update]
  before_action :authenticate_user!, :verify_admin
  before_action :load_suggested_product, only: [:edit, :update, :destroy]
  layout "admin"

  def index
    params[:limit] ||= Settings.show_limit.show_6
    @search = Suggest.ransack params[:q]
    @q = Suggest.search params[:q]
    @suggests = @q.result(distinct: true)
      .order_by_creation_time_desc.page(params[:page]).per params[:limit].to_i
  end

  def update
    unless suggest_params.nil?
      if @suggest.update_attributes suggest_params
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
  def suggest_params
    params.permit :status
  end
end
