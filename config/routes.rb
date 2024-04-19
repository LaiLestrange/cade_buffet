Rails.application.routes.draw do
  devise_for :buffet_admins
  root to: 'home#index'
  resources :buffets, only: [:index, :new, :create]
end
