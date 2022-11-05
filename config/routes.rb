Rails.application.routes.draw do
  resources :products
  resources :providers, except: [:show]
  resources :customers
  resources :invoices do
    resources :items, except: [:show, :index]
  end
end
