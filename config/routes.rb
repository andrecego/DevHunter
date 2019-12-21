# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  devise_for :hunters

  root to: 'home#index'
  resources :headhunters, only: %i[index show]
  resources :users, only: :index
  resources :jobs, only: %i[index new create show] do
    get 'search', on: :collection
  end
  resources :profiles, only: %i[index new create show edit update] do
    resources :comments, only: %i[new create]
  end
  resources :inscriptions, only: %i[index create] do
    put 'star', on: :member
  end
end
