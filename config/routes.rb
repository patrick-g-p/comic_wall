Rails.application.routes.draw do
  root 'comics#index'

  get '/register', to: 'users#new'
  resources :users, except: [:index]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :comics, except: [:destroy] do
    collection do
      get '/search', to: 'comics#search'
    end

    resources :discussions, only: [:new, :create, :show] do
      resources :replies, only: [:create]
    end
  end

  resources :to_read_items, only: [:create, :destroy]
  get '/reading_list', to: 'to_read_items#index'
  post '/reading_list', to: 'to_read_items#update_list'
end
