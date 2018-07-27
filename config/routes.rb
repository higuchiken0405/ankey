Rails.application.routes.draw do

  get 'sessions/new'
  root "pages#index"
  get "/signup",  to: "users#new"
  resources :users
  resources :workbooks

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

end
