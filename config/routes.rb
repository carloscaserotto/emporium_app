Rails.application.routes.draw do
  
 
  get 'catalog/index'
  get 'catalog/show/:id', to: 'catalog#show'
  get 'catalog/search', to: 'catalog#search'
  get 'catalog/latest'
  get 'catalog/rss', to: 'catalog#rss', format: 'xml'
  
  get 'cart/clear', to: 'cart#clear'
  get 'cart/:id', to: 'cart#add'
  post 'cart/:id', to: 'cart#add'
  get 'cart/dell/:id', to: 'cart#dell'
  
  
  
  resources :books
  resources :publishers
  get 'about', to: 'about#index'
  #get 'about/show', to: 'about#show'
  #get 'about/add', to: 'about#add'
  resources :author
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end