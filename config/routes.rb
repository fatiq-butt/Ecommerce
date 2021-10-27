Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  scope '/admin' do
    resources :users
  end
  get '/users', to: redirect('users/sign_in')
  root to: 'main#index'
end
