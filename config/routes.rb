Rails.application.routes.draw do

  scope "(:locale)", :locale => /en|vi/ do
    root "static_pages#index"
    get "/login", to: "sessions#new"
    get "/contact", to: "static_pages#contact"
    get "/help", to: "static_pages#help"
    get "/logout", to: "sessions#logout"
    get "/profile", to: "users#show"
    post "/signup", to: "users#create"
    post "/login", to: "sessions#login"
    resources :users
    resources :admins
    resources :statistics, only: :show
    resources :products
    get "/test", to: "products#test"
  end
end
