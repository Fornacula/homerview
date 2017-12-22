Rails.application.routes.draw do
  scope "(:locale)", locale: /en|et/ do
    devise_for :users
    root to: 'invoices#index'
    resources :services
    resources :invoices
  end
end
