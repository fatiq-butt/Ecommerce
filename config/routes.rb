Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations"}

  namespace :admin do
    resources :users
  end

  root to: 'main#index'
  get '/users', to: redirect('users/sign_in')
end
