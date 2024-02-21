Rails.application.routes.draw do
 get '/items', to: 'items#index'
 root 'items#index'
end
