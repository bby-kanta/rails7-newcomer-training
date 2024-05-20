Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  root to: "homes#index"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up", to: "rails/health#show", as: :rails_health_check
  get "homes", to: "homes#index"
  resources :posts
  
  get "users/index", to: "users#index"
  get "users/:id", to: "users#show", as: "user"

  resource :favorites, only: [:create, :destroy]
  
  resource :relationships, only: [:create, :destroy]
  get "followings" => "relationships#followings", as: "followings"
  get "followers" => "relationships#followers", as: "followers"
  
  # Defines the root path route ("/")
  # root "posts#index"
end
