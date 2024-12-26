Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  get "up" => "rails/health#show", as: :rails_health_check

  root to: "home#index"

  get 'products' => 'customer/products#index'
  get 'products/:id' => 'customer/products#show'
  get 'checkout/:id' => 'customer/checkout#show'
  post 'place_order' => 'customer/checkout#place_order'
  get 'receipt/:id' => 'customer/checkout#receipt'
  
  namespace :customer do
    get 'products' => 'products#index', as: :products
    get 'products/:id' => 'products#show', as: :product
    get ':id/checkout/' => 'checkout#show', as: :single_checkout
    get 'cart/checkout' => 'checkout#show', as: :cart_checkout
    post 'place_order' => 'checkout#place_order', as: :place_order
    get 'receipt/:id' => 'checkout#receipt', as: :receipt
    get 'cart' => 'cart#show', as: :cart
    post 'add_to_cart/:id' => 'cart#add_to_cart', as: :add_to_cart
    delete 'remove_from_cart' => 'cart#remove_from_cart', as: :remove_from_cart #not ready yet
    post 'print_receipt/:id' => 'checkout#print_receipt', as: :print_receipt
  end

  namespace :seller do
    root to: "products#dashboard", as: :root
    get 'dashboard' => 'products#dashboard', as: :dashboard
    get 'products' => 'products#index', as: :products
  end
end
