Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "callbacks",
    registrations: "registrations"
  }
  scope "(:locale)", locale: /en|vn|jp/ do
    namespace :admin do
      root "categories#index"
      resources :categories
      resources :products
      resources :users
    end
    get "/pages/*page" => "pages#show"
    root "pages#home"
    resources :suggests
    resources :users
  end
end
