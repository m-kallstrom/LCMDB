Rails.application.routes.draw do

  root 'movies#index'


  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/movies/search' => 'movies#search'
  get '/movies/confirm' => 'movies#confirm'

  resources :users, only: [:new, :create, :show, :index]
  resources :movies, only: [:new, :create, :show, :index]
  resources :ratings

end
