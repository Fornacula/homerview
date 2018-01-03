Rails.application.routes.draw do
  root to: 'home#welcome', as: 'welcome'
  devise_for :users, class_name: 'FormUser'
  resources :users, only: [:index]
  resources :services
  resources :invoices
end
