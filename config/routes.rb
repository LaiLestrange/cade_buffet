Rails.application.routes.draw do
  devise_for :buffet_admins
  root to: 'home#index'
  resources :buffets, only: [:index, :show, :new, :create, :edit, :update]
  resources :event_types, only: [:new, :create]
end
