Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations"}

  root to: 'main#index'

  devise_scope :user do
    get 'profile', to: 'registrations#show'
    get 'profile/edit', to: 'registrations#edit'
  end

  namespace :admin do
    resources :users
    resources :products
    resources :categories
    resources :coupons
  end
end
