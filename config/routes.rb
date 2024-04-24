Rails.application.routes.draw do
  devise_for :buffet_admins
  root to: 'home#index'
  resources :buffets, only: [:index, :show, :new, :create, :edit, :update]
  resources :event_types, only: [:show, :new, :create]
  resources :payment_methods, only: [:new, :create]
  resources :event_prices, only: [:new, :create]
end
