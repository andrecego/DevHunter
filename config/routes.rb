Rails.application.routes.draw do
  devise_for :users
  devise_for :hunters
  
  root to: 'home#index'
  get '/signup', to: 'home#signup'
  resources :headhunters, only: [:index, :show]
  resources :users, only: [:index]
  resources :jobs, only: [:index, :new, :create, :show]
end
