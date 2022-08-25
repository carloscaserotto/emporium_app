Rails.application.routes.draw do
  get 'checkout/index'
  get 'checkout/place_order'
  get 'checkout/thank_you'
  devise_for :users
  root 'home#index'
  
  get 'catalog/index'
  get 'catalog/show/:id', to: 'catalog#show'
  get 'catalog/search', to: 'catalog#search'
  get 'catalog/latest'
  get 'catalog/rss', to: 'catalog#rss', format: 'xml'
  
  get 'cart/clear', to: 'cart#clear'
  get 'cart/:id', to: 'cart#add'
  post 'cart/:id', to: 'cart#add'
  get 'cart/dell/:id', to: 'cart#dell'
  
  get 'checkout', to: 'checkout#index'
  post 'checkout', to: 'checkout#place_order'
  get 'checkout/thanks', to: 'checkout#thank_you'
  
  resources :books
  resources :publishers
  get 'about', to: 'about#index'
  #get 'about/show', to: 'about#show'
  #get 'about/add', to: 'about#add'
  resources :author
  resources :posts do
    resources :comments
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
