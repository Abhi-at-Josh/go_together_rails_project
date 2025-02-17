Rails.application.routes.draw do
  # Users routes
  resources :users, except: [:new, :edit]
  post "/users/signup", to: "users#signup"
  post "/users/login", to: "users#login"

  # Authentication routes for login (handling both user and admin login)
  post "/auth/login", to: "authentication#login"

  # Admin routes
  resources :admins, only: [:index, :show, :update, :destroy]
  post '/admins/signup', to: 'admins#signup'
  post '/admins/login', to: 'admins#login'
  
  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  resources :rides
  resources :ratings
  resources :bookings
  # Other routes like service worker, manifest for PWA
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
