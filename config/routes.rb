Rails.application.routes.draw do

  root "pages#index"
  get "/signup",  to: "users#new"
  resources :users do
    resources :calendar, only: :index
  end
  get 'events', to: 'events#show'
  post 'events/create', to: 'events#create'
  patch 'events/update', to: 'events#update'
  delete 'events/destroy', to: 'events#destroy'

  resources :workbooks do
    resources :question_answers do
      collection do
        post :import
      end
    end
  end
  get "/workbooks/:id/slider", to: "workbooks#slider"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  post "/memories", to: "memories#create"
  delete "/memories", to: "memories#destroy"

  post "/favorites", to: "favorites#create"
  delete "/favorites", to: "favorites#destroy"

  get 'calendar/index'
end
