# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#welcome', as: 'welcome'
  devise_for :users,
    class_name: 'FormUser',
    controllers: {
      omniauth_callbacks: 'omniauth_callbacks',
      registrations: 'registrations'
    }
  resources :users, only: %i[show index]
  resources :services
  resources :invoices
  resources :communities do
    resources :invitations, only: %i[new create show destroy]
  end
end
