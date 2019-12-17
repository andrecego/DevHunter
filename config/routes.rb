Rails.application.routes.draw do
  devise_for :users
  devise_for :hunters

  root to: 'home#index'
  get '/signup', to: 'home#signup'
  get '/signin', to: 'home#signin'
  resources :headhunters, only: [:index, :show]
  resources :users, only: [:index]
  resources :jobs, only: [:index, :new, :create, :show]
  resources :profiles, only: [:index, :new, :create, :show, :edit, :update]
end
