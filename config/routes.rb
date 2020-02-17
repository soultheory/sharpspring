Rails.application.routes.draw do
  resources :notes, only: [:new, :edit, :update, :create, :destroy]

  get "login",    to: "sessions#new",     as: :new_session
  post "login",   to: "sessions#create",  as: :sessions
  match "logout", to: "sessions#destroy", as: :destroy_session, via: [:get, :post, :delete]

  get "signup",   to: "registrations#new",    as: :new_registration
  post "signup",  to: "registrations#create", as: :registrations

  get "miscellaneous", to: "dashboard#miscellaneous", as: :miscellaneous

  root "dashboard#index"
end
