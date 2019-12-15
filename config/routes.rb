Rails.application.routes.draw do
  devise_for :users
  devise_for :hunters
  root to: 'home#index'
  resources :headhunters, only: [:index]
  resources :users, only: [:index]
  resources :jobs, only: [:new, :create, :show]
end
