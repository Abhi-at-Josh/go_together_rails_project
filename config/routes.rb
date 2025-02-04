Rails.application.routes.draw do
  # Devise authentication for admins
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations',
    passwords: 'admins/passwords'
  }

  # Admin namespace for admin dashboard and actions
  namespace :admin do
    root to: "admins_controller#index"  # Admin dashboard root
    resources :users, only: [:index, :show, :update, :destroy]  # Admin actions for users
  end

  # Authentication route for general user login
  post "/auth/login", to: "authentication#login"

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check
  
  # Resources for other models
  resources :users, except: [:new, :edit]  # Excluding new and edit, as admin will handle user creation
  resources :rides
  resources :ratings
  resources :bookings

  # Routes for Progressive Web App (PWA)
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
