Rails.application.routes.draw do
  # devise auth
  devise_for :users

  # courses routes
  resources :courses, only: [:index, :create]
  resources :lessons, only: [:index]

  # rails health check
  get "up" => "rails/health#show", as: :rails_health_check

  # root route
  root "courses#index"
end
