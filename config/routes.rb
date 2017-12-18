Rails.application.routes.draw do
  scope "(:locale)", locale: /en|et/ do
    devise_for :users
    root to: 'users#index'
    resources :services
    resources :invoices, only: [:index, :new, :create]
  end
end
