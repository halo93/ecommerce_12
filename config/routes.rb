Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vn|jp/ do
    namespace :admin do
      root "categories#index"
      resources :categories
      resources :products
    end
    get "/pages/*page" => "pages#show"
    root "pages#home"
  end
end
