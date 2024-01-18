Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "products#index"
  post '/submit' ,to: 'orders#submit'
  resources :orders
  resources :products
  devise_for :users

end
