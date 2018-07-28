Rails.application.routes.draw do

  root "pages#index"
  get "/signup",  to: "users#new"
  resources :users
  resources :workbooks do
    resources :question_answers
  end


  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

end
