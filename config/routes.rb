Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations"}
  root to: 'main#index'
  get '/users', to: redirect('users/sign_in')
end
