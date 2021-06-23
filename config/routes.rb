# frozen_string_literal: true

Rails.application.routes.draw do
  resources :orders
  resources :products
  devise_for :users
  root 'home#index'

  namespace :webhook, only: :create do
    resources :store_hippo_events, only: [:create]
  end
  resources :home, only: :index
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
