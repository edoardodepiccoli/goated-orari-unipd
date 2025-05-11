Rails.application.routes.draw do
  # devise auth
  devise_for :users

  # scraper API endpoints
  get "scraper/courses"
  get "scraper/lessons"

  # courses routes
  resources :courses, only: [:index, :create]

  # rails health check
  get "up" => "rails/health#show", as: :rails_health_check

  # root route
  root "courses#index"
end
