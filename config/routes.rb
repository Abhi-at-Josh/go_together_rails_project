Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: "admins/sessions",
    registrations: "admins/registrations",
    passwords: "admins/passwords"
  }

  namespace :admin do
    root to: "admins_controller#index"
    resources :users, only: [ :index, :show, :update, :destroy ]
  end

  post "/auth/login", to: "authentication#login"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :users, except: [ :new, :edit ]
  resources :rides
  resources :ratings
  resources :bookings
  resources :ride_requests do
    collection do
      post "booking"
    end
  end

  resources :admins do
    collection do
      get :rides, to: "admins#rides_show"
      get :users, to: "admins#users_index"
      get :ratings, to: "admins#ratings"
      get :bookings, to: "admins#bookings"
    end
    member do
      get "users/:user_id", to: "admins#users_show", as: :user_show
    end
  end

  post "/admins/signup", to: "admins#signup"
  post "/admins/login", to: "admins#login"
  post "/users/signup", to: "users#signup"
  # Routes for Progressive Web App (PWA)
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
