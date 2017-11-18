Rails.application.routes.draw do

  root 'movies#index'


  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/movies/search' => 'movies#search'
  post '/movies/confirm' => 'movies#confirm'

  resources :users, only: [:new, :create, :show, :index]
  resources :movies, except: [:edit, :update]
  resources :ratings, except: [:edit, :update, :destroy]

end
