Rails.application.routes.draw do
  devise_for :users
  scope "(:locale)", locale: /en|vn|jp/ do
    namespace :admin do
      root "categories#index"
      resources :categories
      resources :products
    end
    get "/pages/*page" => "pages#show"
    root "pages#home"
  end
  resources :users
end
