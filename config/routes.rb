Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: { registrations: "registrations" }
  root to: 'pages#home'

  get 'preferences', to: "pages#preferences", as: :preferences # this redirects user after successful sign up

  get 'preview', to: 'pages#preview'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'studiespost', to: 'pages#studiespost', as: :studiespost
  get 'careerpost', to: 'pages#careerpost', as: :careerpost
  get 'relationshippost', to: 'pages#relationshippost', as: :relationshippost
  get 'healthpost', to: 'pages#healthpost', as: :healthpost

end
