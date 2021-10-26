Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  get '/users', to: redirect('users/sign_in')
  root to: 'main#index'
end
