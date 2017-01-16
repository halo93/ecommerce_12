class SuggestsController < ApplicationController
  before_action :authenticate_user!

  def index
    params[:limit] ||= Settings.show_limit.show_6
    @search = current_user.suggests.ransack params[:q]
    @q = current_user.suggests.search params[:q]
    @suggests = @q.result(distinct: true).order_by_updated_time
      .page(params[:page]).per params[:limit].to_i
  end

  def show
  end

  def create
    @suggest = current_user.suggests.build suggest_params
    if @suggest.save
      flash[:success] = t ".success"
      redirect_to suggests_path
    else
      flash[:danger] = t ".danger"
      render :new
    end
  end

  private
  def suggest_params
    params.require(:suggest).permit :title, :content, :category_id
  end
end
