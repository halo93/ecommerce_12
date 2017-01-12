class Admin::UsersController < ApplicationController
  load_and_authorize_resource except: [:update, :destroy]
  before_action :authenticate_user!, :verify_admin
  before_action :load_user, only: [:edit, :update, :destroy]
  layout "admin"

  def index
    params[:limit] ||= Settings.show_limit.show_6
    @search = User.ransack params[:q]
    @q = User.search params[:q]
    @users = @q.result(distinct: true)
      .order_by_creation_time.page(params[:page]).per params[:limit]
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t".profile"
    else
      flash[:danger] = t".update_fail"
    end
    redirect_back fallback_location: :back
  end

  def destroy
    if @user.destroy
      flash[:success] = t".success"
    else
      flash[:danger] = t".danger"
    end
    redirect_back fallback_location: :back
  end

  private
  def user_params
    params.permit :role
  end
end
