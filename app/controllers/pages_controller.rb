class PagesController < ApplicationController
  before_action :authenticate_user!

  def show
    if valid_page?
      render template: "pages/#{params[:page]}"
    else
      render_404
    end
  end

  private
  def valid_page?
    File.exist? Pathname.new(Rails.root +
      "app/views/pages/#{params[:page]}.html.erb")
  end
end
