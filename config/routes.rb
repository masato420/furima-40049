Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :purchases, only: [:create, :new]
  end
  resources :users, only: [:show] 
end