Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"

  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"

  resources :users

  resources :posts

  resource :profile, only: %i[show edit update]

  namespace :admin do
    root "dashboard#index"
    resources :users
    resources :posts
  end
end
