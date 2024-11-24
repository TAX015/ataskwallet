Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "application#home"

  get "dashboard", to: "dashboards#index", as: "dashboard"

  get "login", to: "sessions#new"
  get "logout", to: "sessions#destroy"
  post "login", to: "sessions#create"
end
