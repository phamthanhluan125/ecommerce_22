Rails.application.routes.draw do

  mount Ckeditor::Engine => "/ckeditor"
  scope "(:locale)", :locale => /en|vi/ do
    root "static_pages#index"
    get "/login", to: "sessions#new"
    get "/contact", to: "static_pages#contact"
    get "/help", to: "static_pages#help"
    get "/logout", to: "sessions#logout"
    get "/profile", to: "users#show"
    post "/signup", to: "users#create"
    post "/login", to: "sessions#login"
    get "/error", to: "static_pages#error"
    get "/error1", to: "static_pages#error1"

    resources :users
    resources :statistics, only: :show
    resources :categories
    resources :imports, only: :create
    resources :products
    resources :products
    resources :rates
    resources :suggests
    resources :carts
    resources :orders
    resources :order_details
    resources :payments
    resources :notification_emails, only:[:create, :new]

    namespace :admin do
      resources :orders
      resources :rates
      resources :suggests
      resources :carts
      resources :categories
      resources :users
      resources :admins
      resources :products
      resources :orders
      resources :order_details, only: :destroy
    end
  end
end
