Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  devise_scope :user do
    get 'profile', to: 'registrations#show'
    get 'user/edit', to: 'registrations#edit'
  end

  namespace :admin do
    resources :users
  end

  root to: 'main#index'
end
