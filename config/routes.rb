Rails.application.routes.draw do
  root to: 'homes#top'
  get 'home/about', to: 'homes#about'
  devise_for :users
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy]
  resources :users, only: [:show, :index, :edit, :update]
end
