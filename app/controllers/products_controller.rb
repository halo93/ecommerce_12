class ProductsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource find_by: :slug

  def index
  end

  def show
    @comments = @product.comments.order(created_at: :desc)
  end
end
