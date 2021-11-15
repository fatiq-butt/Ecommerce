Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  
  devise_scope :user do
    get 'user/edit', to: 'registrations#edit'
  end

  root to: 'main#index'
  
  namespace :admin do
    resources :users
    resources :products
    resources :categories
    resources :coupons
  end

  resources :products
  resources :checkout, only: [:index]
  resources :users, only: [:update]

  get 'cart', to: "carts#show", as: "cart"
  delete 'carts/:id', to: "carts#destroy"
  post 'line_items/:id/add', to: "line_items#add_quantity", as: "line_item_add"
  post 'line_items/:id/reduce', to: "line_items#reduce_quantity", as: "line_item_reduce"
  post 'line_items', to: "line_items#create"
  get 'line_items/:id', to: "line_items#show", as: "line_item"
  delete 'line_items/:id', to: "line_items#destroy"
end
