Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vn|jp/ do
    get "/pages/*page" => "pages#show"
    root "pages#home"
  end
end
