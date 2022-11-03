Rails.application.routes.draw do
  resources :products
  resources :providers, except: [:show]
  resources :customers
end
