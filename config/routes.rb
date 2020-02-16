Rails.application.routes.draw do
  resources :administrators

  root "home#index"
end
