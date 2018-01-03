Rails.application.routes.draw do
  root to: 'home#welcome', as: 'welcome'
  devise_for :users
  resources :users, only: [:index]
  resources :services
  resources :invoices
end
