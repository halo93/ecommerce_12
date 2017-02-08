require "rails_helper"
require "products_controller"

RSpec.describe ProductsController, type: :controller do
  before(:each) do
    category = Category.new FactoryGirl.attributes_for :category
    category.save!
  end

  describe "GET index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders index successfully" do
      get :index
      expect(response).to render_template :index
    end

    it "display recent products" do
      product = FactoryGirl.create :product
      get :show, params: {id: product.slug}
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show/:id" do
    it "responds successfully with an HTTP 200 status code" do
      product = FactoryGirl.create :product
      get :show, params: {id: product.slug}
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "assigns the requested product to @product" do
      product = FactoryGirl.create :product
      get :show, id: product.slug
      expect(assigns(:product)).to eq product
    end

    it "renders the show template" do
      product = FactoryGirl.create :product
      get :show, id: product.slug
      expect(response).to render_template("show")
    end

    it "delete first recent product in queue" do
      session[:recent] = []
      (Settings.recent_items + 1).times do |i|
        product = FactoryGirl.create :product
        session[:recent].push i
        get :show, params: {id: product.slug}
      end
      expect(session[:recent].size).to eq Settings.recent_items
    end
  end
end
