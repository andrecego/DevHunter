Rails.application.routes.draw do
  devise_for :users
  devise_for :hunters
  
  root to: 'home#index'
  get '/signup', to: 'home#signup'
  resources :headhunters, only: [:index]
  resources :users, only: [:index]
  resources :jobs, only: [:new, :create, :show]
end
