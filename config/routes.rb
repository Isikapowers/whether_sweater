Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :forecast, only: [:index]
      resources :backgrounds, only: [:index]
      resources :users, only: [:create]
      get '/users', to: 'users#find'
      resources :sessions, only: [:create]
      resources :road_trip, only: [:index, :create]
    end
  end
end
