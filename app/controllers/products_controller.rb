class ProductsController < ApplicationController
  load_and_authorize_resource find_by: :slug

  def index
    if session[:recent]
      @recent_products = session[:recent]
        .map{|id| Product.find_by(id: id)}.reverse
    end
    @search = Product.ransack params[:q]
    @q = Product.search params[:q]
    @products = @q.result(distinct: true).page(params[:page])
      .per Settings.show_limit.show_6
    if request.xhr?
      render partial: "product", collection: @products
    end
  end

  def show
    @comments = @product.comments.order(created_at: :desc)
    session[:recent] = [] unless session[:recent]
    if session[:recent].length > Settings.recent_items
      session[:recent].delete_at(0)
    end
    session[:recent].push @product.id unless session[:recent]
        .include? @product.id
  end
end
