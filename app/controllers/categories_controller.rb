class CategoriesController < ApplicationController
  load_resource

  def show
    @search = @category.products.ransack params[:q]
    @q = @category.products.search params[:q]
    @products = @q.result(distinct: true).page(params[:page])
      .per Settings.show_limit.show_6
    render partial: "products/product", collection: @products if request.xhr?
  end
end
