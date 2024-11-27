Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "application#home"

  get "dashboard", to: "dashboards#index", as: "dashboard"

  get "login", to: "sessions#new"
  get "logout", to: "sessions#destroy"
  post "login", to: "sessions#create"

  resources :users

  resources :stocks do
    collection do
      get "get_prices"
      get "prices"
    end
  end

  resources :transactions do
    collection do
      get "deposit", to: "transactions#deposit"
      get "withdraw", to: "transactions#withdraw"
      get "transfer", to: "transactions#transfer"

      post "deposit", to: "transactions#create_deposit"
      post "withdraw", to: "transactions#create_withdraw"
      post "transfer", to: "transactions#create_transfer"
    end
  end
end
