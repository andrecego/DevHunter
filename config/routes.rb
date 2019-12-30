# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  devise_for :hunters

  root to: 'home#index'
  resources :headhunters, only: %i[index show]
  resources :jobs, only: %i[index new create show] do
    get 'search', on: :collection
    put 'inactivate', on: :member
  end
  resources :profiles, only: %i[index new create show edit update] do
    resources :comments, only: %i[new create]
    get 'approvals', on: :member
  end
  resources :inscriptions, only: %i[index create] do
    put 'star', on: :member
    resources :rejections, only: %i[new create show]
    resources :approvals, only: %i[new create show] do
      resources :responses, only: %i[new create]
    end
  end
end
