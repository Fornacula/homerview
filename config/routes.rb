Rails.application.routes.draw do
  scope "(:locale)", locale: /en|et/ do
    root to: 'invoices#index'
    devise_for :users
    resources :users, only: [:index]
    resources :services
    resources :invoices
  end
end
