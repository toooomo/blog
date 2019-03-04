Rails.application.routes.draw do
  root 'contents#index'
  devise_for :users
  resources :contents
  resources :users, only: [:show]
end
