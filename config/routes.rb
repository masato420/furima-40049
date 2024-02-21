Rails.application.routes.draw do
 get '/items', to: 'items#index'
 root 'welcome#index'
end
