Rails.application.routes.draw do
  resources :posts, only: [:index, :create, :update, :show, :destroy]
  resources :users, only: [:create, :update, :show]
  resources :login, only: [:create]
  resources :temp_links, only: [:create, :show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
