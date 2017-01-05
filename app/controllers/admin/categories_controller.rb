class Admin::CategoriesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, :verify_admin
  layout "admin"

  def index
  end
end
