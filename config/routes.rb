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
  resources :checkout, only: [:index,:create]
  resources :users, only: [:update]

  namespace :api do
    namespace :v1 do
      resources :products, only: [:index, :show, :create, :update, :destroy]
    end
  end

  get 'cart', to: "carts#show", as: "cart"
  delete 'carts/:id', to: "carts#destroy"
  post 'line_items/:id/add', to: "line_items#add_quantity", as: "line_item_add"
  post 'line_items/:id/reduce', to: "line_items#reduce_quantity", as: "line_item_reduce"
  post 'line_items', to: "line_items#create"
  get 'line_items/:id', to: "line_items#show", as: "line_item"
  delete 'line_items/:id', to: "line_items#destroy"
  post 'checkout/confirmation', to: "checkout#confirmation", as: "place_order"
  post 'checkout/create_order', to: "checkout#create_order", as: "create_order"
  get 'checkout/successful', to: "checkout#successful_order", as: "order_successful"
end
