Rails.application.routes.draw do

  get "up" => "rails/health#show", as: :rails_health_check

  root to: "home#index"

  get 'products' => 'customer/products#index'
  get 'products/:id' => 'customer/products#show'
  
  namespace :customer do
    get 'products' => 'products#index', as: :products
    get 'products/:id' => 'products#show', as: :product
  end
end
