Rails.application.routes.draw do
  devise_for :users
  devise_for :hunters

  root to: 'home#index'
  resources :headhunters, only: [:index, :show]
  resources :users, only: [:index]
  resources :jobs, only: [:index, :new, :create, :show] do
    get 'search', on: :collection
  end
  resources :profiles, only: [:index, :new, :create, :show, :edit, :update] do
    resources :comments, only: %i[new create]
  end
  resources :inscriptions, only: [:index, :create] do
    put 'star', on: :member
  end
end
