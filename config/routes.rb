Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations"}
  
  devise_scope :user do
    get 'user/edit', to: 'registrations#edit'
  end

  root to: 'main#index'

  namespace :admin do
    resources :users
    resources :products
    resources :categories
  end
end
