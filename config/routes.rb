Rails.application.routes.draw do
  root to: 'home#index'

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
  resources :orders, only: [:new, :create, :show]


  get 'search', to:"home#search"
end
