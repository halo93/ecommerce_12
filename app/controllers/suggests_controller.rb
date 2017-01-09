class SuggestsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_suggested_product, only: :show
  before_action :load_all_categories

  def index
    params[:limit] ||= 6
    @search = current_user.suggests.ransack params[:q]
    @suggests = current_user.suggests.order_by_creation_time
      .page(params[:page]).per params[:limit]
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
  def load_suggested_product
    @suggest = Suggest.find_by id: params[:id]
    unless @suggest
      flash.now[:warning] = t "errors.messages.not_found"
      render_404
    end
  end

  def suggest_params
    params.require(:suggest).permit :title, :content, :category_id
  end
end
