Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "callbacks",
    registrations: "registrations"
  }
  scope "(:locale)", locale: /en|vn|jp/ do
    namespace :admin do
      root "charts#index"
      resources :categories
      resources :products
      resources :users
      resources :suggests
      resources :orders
      resources :charts, only: :index
      resources :products do
        collection{post :import}
      end
    end
    get "/pages/*page" => "pages#show"
    post "/rate", to: "rater#create", as: "rate"
    resources :suggests
    resources :products do
      resources :comments
    end
    resources :users, :products, :orders, :categories
    get "/cart", to: "cart#index"
    delete "/cart/:id/delete", to: "cart#destroy"
    post "/cart/:id", to: "cart#create"
    patch "/cart", to: "cart#update"
    get "/cart/:id/edit", to: "cart#edit"
    root "products#index"
  end
end
