Rails.application.routes.draw do
  get 'horoscopes/show', to: 'horoscopes#show'
  # devise_for :users
  devise_for :users, controllers: { registrations: "registrations" }

  root to: 'pages#home'

  resources :users, only: [:index,:show,:update] do
    collection do
      get :masters
    end
    member do
      post :appointments
      patch :approve_appointments # what is this?
    end
  end

  resources :appointments, only: [:index, :update, :destroy] do
    resources :payments, only: :new
  end

  get "appointments/:id", to: "appointments#really_destroy", as: :really_destroy_appointment

  get 'preview', to: 'pages#preview'
  get 'preferences', to: "pages#preferences", as: :preferences # this redirects user after successful sign up

  get 'dashboard', to: 'pages#dashboard', as: :dashboard

  resources :categories, only: [:show] # what is this?

  mount StripeEvent::Engine, at: '/stripe-webhooks'
end
