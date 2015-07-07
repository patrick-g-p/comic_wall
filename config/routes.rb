Rails.application.routes.draw do
  root 'comics#index'

  get '/register', to: 'users#new'
  resources :users, except: [:index]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
