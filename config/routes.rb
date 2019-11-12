Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :listings, only: [:index, :show, :create, :update, :destroy]
      resources :categories, only: [:index]
      resources :users, only: [:update, :destroy]
      resources :venues, only: [:create, :show, :index, :update, :destroy]
      resources :reviews, only: [:create, :update, :destroy]
      post '/like', to: 'likes#toggle'
      post '/login', to: 'auth#create'
      post '/register', to: 'users#create'
      post '/validate', to: 'auth#validate'
    end
  end


end
