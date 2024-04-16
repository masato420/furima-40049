Rails.application.routes.draw do
  devise_for :users
 root 'items#index'
 resources :users, only: [:new, :create, :show, :edit, :update, :destroy]
 resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
   resources :purchases, only: [:create, :new]
 end
end
