Rails.application.routes.draw do

  get "up" => "rails/health#show", as: :rails_health_check

  root to: "home#index"

  get 'products' => 'customer/products#index'
  get 'products/:id' => 'customer/products#show'
  
  namespace :customer do
    get 'products' => 'products#index', as: :products
    get 'products/:id' => 'products#show', as: :product
    get 'checkout/:id' => 'checkout#show', as: :checkout
    post 'place_order' => 'checkout#place_order', as: :place_order
    get 'receipt/:id' => 'checkout#receipt', as: :receipt
  end
end
