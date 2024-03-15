Rails.application.routes.draw do
  devise_for :users
 get '/items', to: 'items#index'
 root 'items#index'
 resources :users, only: [:new, :create, :show, :edit, :update, :destroy]
 resources :items, only: [:index, :new, :create]
 
end
