Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/logged_in', to: 'sessions#is_logged_in?'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users do
        collection do
          post :authenticate_user
        end
      end
      resources :movies, only: [:index, :create, :edit, :update, :destroy] do
        member do
          get :upcoming_shows
        end
      end
      resources :shows do
        member do
          get :seats
        end
      end
      resources :bookings, only: [:create, :index]
    end
  end
end
