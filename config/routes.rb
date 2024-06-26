Rails.application.routes.draw do
  # APP
  root to: 'home#index'
  get 'search', to:"home#search"

  devise_for :customers,
    path: "customers",
    controllers: {
      sessions: 'customers/sessions'
    }

  devise_for :buffet_admins,
    path: "buffet_admins",
    controllers: {
      sessions: 'buffet_admins/sessions'
    }

  resources :buffets, only: [:index, :show, :new, :create, :edit, :update] do
    resources :event_types, only: [:show, :new, :create]
  end

  resources :payment_methods, only: [:new, :create]
  resources :event_prices, only: [:new, :create]

  resources :orders, only: [:new, :create, :show, :index] do
    resources :invoices, only: [:new, :create]
  end

  resources :orders do
    put :confirm_event, on: :member
  end

  # API

  namespace :api do
    namespace :v1 do
      resources :buffets, only: [:show, :index]
      post 'search', to: "buffets#search"
      post 'availability', to: "buffets#availability"
    end
  end
end
