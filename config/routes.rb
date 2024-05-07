Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  root to: "homes#index"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up", to: "rails/health#show", as: :rails_health_check
  get "homes", to: "homes#index"
  # resource :posts
  resources :posts
  # get "posts/:id", to: "posts#show", as: "post"
  # get "posts/:id/edit", to: "posts#edit", as: "edit_post"
  # patch "posts/:id", to: "posts#update", as: "update_post"
  # delete "posts/:id", to: "posts#destroy", as: "destroy_post"

  # Defines the root path route ("/")
  # root "posts#index"
end