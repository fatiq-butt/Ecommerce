Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}

  namespace :admin do
    resources :users
  end
  
  root to: 'main#index'
end
