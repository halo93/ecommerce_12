require "rails_helper"
require "support/controller_helpers"

RSpec.describe SuggestsController, type: :controller do
  before :each do
    sign_in FactoryGirl.create :user
  end

  describe "GET #index" do
    it "render template index" do
      get :index
      expect(response).to render_template :index
    end

    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it "ransack search" do
      get :index, q: "hi"
      expect(controller.params[:q]).to eql "hi"
    end
  end

  describe "POST #create" do
    it "create successfully" do
      expect{
        post :create, suggest: FactoryGirl.attributes_for(:suggest)
      }.to change(Suggest,:count).by(1)
      expect(flash[:success]).to be_present
      expect(response).to redirect_to suggests_path
    end

    it "create fail" do
      expect{
        post :create, suggest: FactoryGirl.attributes_for(:suggest, title: nil)
      }.to change(Suggest,:count).by(0)
      expect(flash[:danger]).to be_present
      expect(response).to render_template :new
    end
  end
end
