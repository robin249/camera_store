Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
	  namespace :v1 do
    	post "/register", :to => 'users#register'
    	post "/login", :to => 'users#login'
    	get "/categories", :to => 'categories#index'
    	post "/create_category", :to => 'categories#create'
      get "/category/:id", :to => 'categories#show'
    	get "/products", :to => 'products#index'
    	post "/create_product", :to => 'products#create'
      get '/cart' => 'carts#index'
      post '/add_to_cart' => 'carts#create'

    end
  end
end
