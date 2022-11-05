Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users
  resources :products
  resources :providers, except: [:show]
  resources :customers
  resources :invoices do
    resources :items, except: [:show, :index]
  end
end
