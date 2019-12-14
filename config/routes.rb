Rails.application.routes.draw do
  devise_for :hunters
  root to: 'home#index'
  resources :headhunters, only: [:index]
end
